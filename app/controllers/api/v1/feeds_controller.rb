
class Api::V1::FeedsController < Api::V1::BaseController

   

  def get_posts
	
    frnds = get_frineds_ids(params[:account_id])
    if params[:tag]
      posts = Post.tagged_with(params[:tag])      
    else
      posts = Post.where("status = ? AND account_id = ? OR (account_id IN (?) AND share_with = ? ) OR share_with = ?   ",1 , params[:account_id], frnds, "Friends", "Public").order("id DESC")
    end  
   render json: posts
   

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
  
     
    posts =  Post.create(:account_id=>params[:account_id],:text=>params[:posttextnew],:image=>params[:photo],:video=>params[:video], :status=>1,:share_with=>params[:feed][:share_with])	        
           
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
    
   
      comments =  Comment.create(:account_id=>params[:account_id],:text=>params[:text],:post_id=>params[:post_id],:status=>1)
      if comments.save!
       render :json => comments
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
  
  
   private
  def feedback_params
    params.permit(:category_id, :feedback)
  end
  
end #end of class

