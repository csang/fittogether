
class Api::V1::FeedsController < Api::V1::BaseController
before_action :authenticate_with_token!
 include ActionView::Helpers::DateHelper  
 include ActionView::Helpers::NumberHelper
  include ActionView::Helpers::UrlHelper
 include ActionView::Helpers::OutputSafetyHelper
include ApplicationHelper
include FeedHelper
require 'nokogiri'

  def get_posts
#~ my_string = "abcdefg"
#~ if my_string.include? "cde"
#~ abort("dffdf");
   #~ puts "String includes 'cde'"
#~ end

    frnds = get_frineds_ids(current_user.id)
    if params[:tag] 
      posts = Post.tagged_with(params[:tag]).paginate(:page => params[:page],:per_page => 5)   
      post_count  = Post.tagged_with(params[:tag]).count
    else
    post_count = Post.where("posts.status = ? AND posts.account_id = ? OR (posts.account_id IN (?) AND posts.share_with = ? ) AND posts.share_with = ?   ",1 , current_user.id, frnds, "Friends", "Public").order("id DESC").count
       posts = Post.where("posts.status = ? AND posts.account_id = ? OR (posts.account_id IN (?) AND posts.share_with = ? ) AND posts.share_with = ?   ",1 , current_user.id, frnds, "Friends", "Public").order("id DESC").paginate(:page => params[:page], :per_page => 5)
      
    end 
   
    all_post = Array.new 
    	  posts.each do |post|
			
		    user = get_user_array(post.account) 
		    acc = {}          						
		    acc[:post] = post	
		       
		    acc[:user] = user
		    acc[:comment] = {}	
		    acc[:challenges] = {}		
		    acc[:challengeto] = {}	
		    acc[:fitspot] = {}	
		    acc[:fitbit] = {}	
		    acc[:fitspotcover] = {}	
		    acc[:time] = {}	
		    acc[:fitbits_steps] = {}	
		    acc[:comment][:user] = {}	
		    acc[:comment][:time] = {}	
		    acc[:time] =  time_ago_in_words(post.created_at) 	
		    
				if post.text.include? "@"
					acc[:post_text] = {}	
					acc[:post_text] = post.text
					post.text.split.select {|w| 
						if  w[0] == "@"
							users_name = raw user_links(w)   
							acc[:post_text] = acc[:post_text].gsub(w, users_name)           
						else    
							w.html_safe      
						 end       
					} 
					
			end
				
				 case post.post_type
					when "challenge"
					
						acc[:challenges] =  Challenge.where(:id=> post.group_id).first 	
						accounts =  Account.where(:id=> acc[:challenges][:to_id]).first  
						challengeto = get_user_array(accounts) 
						acc[:challengeto] = challengeto
					when "fitspot"
					
						acc[:fitspotcover] = FitspotCover.where(:fitspot_id => post.group_id, :position => 1 ).first
						acc[:fitspotcover].present? ? acc[:fitspotcover] : ''
						acc[:fitspot] = Fitspot.where(:account_id=> post.account_id).first
						
					when "fitbit"
					
						acc[:fitbit] = Fitbit.where(:account_id => post.account_id).first
						
						acc[:fitbits_steps] = number_to_human( acc[:fitbit].steps, :format => '%n%u', :units => { :thousand => 'K' })
						
					else
					
				end
				
				
		    	   
	           if post.comment.present?	          
				post.comment.each do |come|
				  acc[:comment][come.id] = come		
				  acc[:comment][:time][come.id] = time_ago_in_words(come.created_at) 	
				   user = get_user_array(come.account)
		           acc[:comment][:user][come.id] = user			
				end	
				
				
				
			end 	
		       all_post.push(acc)  	#push hash into array
end 
    #abort(all_post.inspect)
    
    #created_at = time_ago_in_words(posts.created_at) 
    render :json => {'posts' => all_post, 'post_count' => post_count}
  end
  
  def show
     
   posts = Post.find_by_id(params[:id])    
   render json: posts
   

  end
  
  
  def destroy_post
      if params[:gadminid].present?
        
        if  params[:gadminid].to_i == params[:account_id].to_i
          
          post =  Post.where(:id=> params[:id]).first 
         
        else
          post =  Post.where(:id=>params[:id], :account_id => params[:account_id]).first  
        end
      else     
        post =  Post.where(:id=>params[:id], :account_id => params[:account_id]).first
      end
      
      if post.destroy 
        render :json => params[:id]  and return      
      else
        render :json => 0  and return     
      end
  end
  
  
  def create_post
  
     
    #posts =  Post.create(:account_id=>current_user.id,:text=>params[:posttextnew],:image=>params[:photo],:video=>params[:video], :status=>1,:share_with=>params[:feed][:share_with])	        
    posts =  Post.create(:account_id=>current_user.id,:text=>params[:posttextnew],:image=>params[:photo],:video=>params[:video], :status=>1, :post_type => params[:post_type])	        
           
       if posts.save!    
			
          render :json => posts  and return     
      else		   
         render :json => 0  and return     
       end 
 
  
  end
  

  
  def create_album
    album =  Album.create(:account_id => params[:account_id], :title =>'untitled by app')
    if album
      image =  AlbumImage.create(:album_id=>album.id, :image=> params[:album])
	  		
			if image.id.present?
				render :json => album.id
			else         
				render :json => image.errors.messages[:image].to_sentence 
			end 
	else
      render :json => image.errors.full_messages.first
    end 	        
	
  end
  
  def show_album
  
    if params[:id].present?  
      album = Album.where(:id=>params[:id] ,:account_id=>params[:account_id]).first
      if album.present?
        render :json => album
      else
           render :json => 0 and return
      end	
    else
     render :json => 0 and return
    end  
     
    end 
  def delete_record
 	 	if params[:resource] == 'Album'
		 imgs = Album.where(:id=>params[:id],:account_id=> params[:account_id]).first 
		 else
		  imgs = AlbumImage.where(:id=>params[:id]).first 
		 end

		  if imgs.present? && imgs.destroy 
			render :json => params[:id]  and return      
		  else
			render :json => 0  and return     
		  end
		
		end
		
  def update_album
 
	  if params[:album_id]
		  id = params[:album_id]
		  @alb = Album.find(id)
		 if @alb.update_attributes(:title=>params[:title],:share_with =>params[:share_with])	
			   
		  if params[:photo]     
			params[:photo].each { |image|
			  abc = AlbumImage.create(:album_id=>id, :image=> image)
		   
			  if !abc.id.present?
					render :json => abc.errors.messages[:image].to_sentence    and return     
			  end
			 
			}
		  end
	   
		render :json =>  id   and return     
	  else
		render :json => 0 and return
	  end  
  end 
  render :json => 0 and return
end  


# comment on post
def create_comment

      comments =  Comment.create(:account_id=>current_user.id,:text=>params[:text],:post_id=>params[:post_id],:status=>1)
      time = time_ago_in_words(comments.created_at)
      commented_by =  Account.where(:id=>comments.account_id).first	
      if comments.save!
      render :json => {'comments' => comments, 'commented_by' => commented_by, 'time' => time}
=begin
        post = Post.find(params[:post])
        set = email_settings(post.account.id, 'comment_on_post')
        if set.present? || set == 123 
        UserMailer.comment_on_post(post.account.email,request, @account, params[:text] ,post.account.first_name ).deliver
        end
respond_to do |format|
  if params[:gid].present? 
	@groupadminid = params[:gid]
	format.js {  render 'groups/create_group_comment' }
  else

	params[:text].split.select {|w|         
	  if  w[0] == "@" 
		wrd = full_name(w)
		id = Base64.decode64(w)
		params[:text][w] = wrd
		if is_number?(id)
		  @user = Account.find(id)
		  met = email_settings(id, 'mentioned_in')
		  if met.present? || met == 123 
		  UserMailer.mentioned_in(@user.email,request, @account,'Comment', params[:text] ,@user.first_name ).deliver
		  end
		  end
	  end 
	}
	@comment =  Comment.find(@comments.id)
	format.js {  render 'create_comment' }
  end
end
=end 
      else 	   
        render :json => @comments.errors.full_messages  and return     
      end    
   
    
  end
  
   def delete_comment
    
      if params[:gadminid].present?
        
        if  params[:gadminid].to_i == params[:account_id]
          
          cmt = Comment.where(:id=>params[:id]).first
         
        else
          cmt = Comment.where(:id=>params[:id], :account_id => params[:account_id]).first
        end
      else     
        cmt = Comment.where(:id=>params[:id], :account_id => params[:account_id]).first
      end
      if cmt.present? && cmt.destroy 
        render :json => params[:id]  and return      
      else
        render :json => 0  and return     
      end
         
  end
  
    def send_feedback
  
      feedback = Admin::Feedback.create(feedback_params.merge(account_id: params[:account_id]))	
      if feedback.save!  
        render :json => 1  and return     
      else
		    render :json => 0  and return   
      end 	
	  
  end
  
  def scrap_link #to get link post
   doc = Nokogiri::HTML(open(params[:link]))   #lnk is url
   #@title = doc.css('title').text # to get title to display on post
   contents = doc.search("meta[name='description']").map { |n| 
	  n['content'] 
	}
	@contents = contents.join(" ")
	@author = doc.search("author")
	@img = doc.at_xpath("//img[@width > 50 ]/@src ")
	if @img.present?	
		@image =  @img	
		unless @img[/\Ahttp:\/\//] || @img[/\Ahttps:\/\//]
			@image = params[:link] + '/' + @img
		end
    end
     render :json => {'link' => params[:link], 'contents' => contents, 'author' => @author, 'image' => @image}

  end
  
  
  def give_kudos # add delete kudos
   
		  post_id = params[:post_id]     
		  kudos =  Kudo.where(:post_id=>post_id, :account_id=> current_user.id).first   
		  if kudos.present? && kudos.destroy 
			  render :json => 1  and return    
		  else
			  kudos = Kudo.create(:post_id=>post_id, :account_id=> current_user.id)
			  if kudos 
			  	 render :json => 1  and return    
			  else
			      flash[:error] = kudos.errors.full_messages.first
			  end  
		  end

  
  end
  
   private
  def feedback_params
    params.permit(:category_id, :feedback)
  end
  
  
  
end #end of class

