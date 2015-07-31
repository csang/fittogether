class FeedController < ApplicationController

  before_action :get_account  # will return @account
  respond_to :html, :js, :json
  include FeedHelper
 

  def index
    @data = (session[:account].present?) ? session[:account] : nil;
    @profile = 'feed'
    
    if params[:tag]
      @posts = Post.tagged_with(params[:tag])
      
    else
      @posts = Post.where(:status=>1, :group_id => nil).order("id DESC")
    end  
    #abort(session[:oauth_token].inspect)
    if  session[:oauth_token].present?
      session[:connect] ='yes'
      @acc = Account.find(@account.id)
      if @acc.present?
        if @acc.update_attributes(:uid =>session[:uid],:oauth_token =>  session[:oauth_token], :access_secret =>session[:oauth_secret])
          flash[:notice] = "User connected with fitbit ."
          session.delete(:oauth_token)
        else 
          flash[:error] = "Please try again."
        end
      end	
	
    end

  end
  
  def create_post
    #abort(params.inspect)
    if request.xhr?   
      #abort(params[:feed][:share_with].inspect)
	    @posts =  Post.create(:account_id=>@account.id,:text=>params[:posttextnew],:image=>params[:photo],:video=>params[:video], :status=>1,:share_with=>params[:feed][:share_with])	        
      
      respond_to do |format|
        if @posts.save!
          params[:posttextnew].split.select {|w|         
            if  w[0] == "@" 
              wrd = full_name(w)
              id = Base64.decode64(w)
              params[:posttextnew][w] = wrd
              if is_number?(id)
                @user = Account.find(id)
                 met = email_settings(id, 'mentioned_in')
                  if met.present? || met == 123 
                UserMailer.mentioned_in(@user.email,request, @account,'Post', params[:posttextnew], @user.first_name ).deliver
                  end
                end
            end 
          }
          @post = Post.find(@posts.id)
          format.js
        else
		   
          render :json => @posts.errors.full_messages  and return     
        end 
      end
		  
    end
  
  end
  
  
  def create_comment
    #render :layout => false
 
    if request.xhr?    
   
      @comments =  Comment.create(:account_id=>@account.id,:text=>params[:text],:post_id=>params[:post],:status=>1)
      if @comments.save!
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
      else		   
        render :json => @comments.errors.full_messages  and return     
      end    
    end

    
  end
  
  
  
  def create_album
    album =  Album.create(:account_id => @account.id, :title =>'untitled')
    if album
      @image =  AlbumImage.create(:album_id=>album.id, :image=> params[:album])
	  		
			if @image.id.present?
				redirect_to :action => "show_album", :id => album.id
      else
        flash[:error] = @image.errors.messages[:image].to_sentence  
			  redirect_to request.env['HTTP_REFERER'] and return
			end 
		else
      flash[:error] = @image.errors.full_messages.first
      redirect_to request.env['HTTP_REFERER'] and return
    end 	        
	
	end
  
  
  
    
  def show_album
    @profile = 'album'
    if params[:id].present?  
      @album = Album.where(:id=>params[:id] ,:account_id=>@account.id).first
      if !@album.present?
        # flash[:error] = "Album does not exist."  
        redirect_to('/feed')
      end	
    else
      redirect_to('/feed')
    end     

  end
  
  def update_album
 
    if params[:album_id]
      id = Base64.decode64(params[:album_id])
      @alb = Album.find(id)
      @alb.update_attributes(:title=>params[:title],:share_with =>params[:album][:share_with])	
		   
      if params[:photo]     
        params[:photo].each { |image|
          abc = AlbumImage.create(:album_id=>id, :image=> image)
       
          if !abc.id.present?
            flash[:error] = abc.errors.messages[:image].to_sentence  
            redirect_to request.env['HTTP_REFERER'] and return
          end
         
        }
      end
    end  
    flash[:notice] = "Album has been updated successfully."  
    redirect_to :controller =>'profile' , :action => "photos", :id => @account.user_name
  
  end 
  
  def delete_image
 
    if request.xhr?    
      id = Base64.decode64(params[:imgid])
     
      @img =  AlbumImage.where(:id=>id).first
   
      img = @img.destroy
	 
      if img 
        render :json => id  and return      
      else
        render :json => 0  and return     
      end
    
    end
  
  end
  
  
  def delete_post
 
    if request.xhr?    
      id = Base64.decode64(params[:postid])
      if params[:gadminid].present?
        groupadminid = Base64.decode64(params[:gadminid])
        
        if  groupadminid.to_i == @account.id.to_i
          
          @post =  Post.where(:id=>id).first 
         
        else
          @post =  Post.where(:id=>id, :account_id => @account.id).first  
        end
      else     
        @post =  Post.where(:id=>id, :account_id => @account.id).first
      end
      
      if @post.destroy 
        render :json => id  and return      
      else
        render :json => 0  and return     
      end
    
    end
  
  end
  
  def delete_comment
    
    if request.xhr?    
      id = Base64.decode64(params[:id])   
      if params[:gadminid].present?
        groupadminid = Base64.decode64(params[:gadminid])
        
        if  groupadminid.to_i == @account.id.to_i
          
          @cmt = Comment.where(:id=>id).first
         
        else
          @cmt = Comment.where(:id=>id, :account_id => @account.id).first
        end
      else     
        @cmt = Comment.where(:id=>id, :account_id => @account.id).first
      end
      if @cmt.destroy 
        render :json => id  and return      
      else
        render :json => 0  and return     
      end
    
    end
    
  end
  
  def delete_album
    #render :layout => false
    if request.xhr?    
    
      @img =  Album.where(:id=>params[:id],:account_id=>@account_id)
      @img.destroy
	 
      if img 
        render :json => params[:id]  and return      
      else
        render :json => 0  and return     
      end
    
    end
  
  end
  
     
  def un_sync
    @acc = Account.find(@account.id)
  
		if @acc.present?
			if @acc.update_attributes(:oauth_token => nil, :access_secret => nil)
        @fb =  Fitbit.where(:account_id=>@account.id).first 
        if @fb.present? 
          @fb.destroy
        end
			  flash[:notice] = "Successfully disconnected  with fitbit ."
			   
			else 
			  flash[:error] = "Please try again."
			end
    end	
    redirect_to('/feed')
  end  
  
  
  def send_feedback
    if request.xhr?  
      @feedback = Admin::Feedback.create(feedback_params.merge(account_id: @account.id))	
      if @feedback.save!  
        render :json => 1  and return     
      else
		    render :json => 0  and return   
      end 	
		 
		
		end
    
  end
  
   
  private
  def feedback_params
    params.permit(:category_id, :feedback)
  end
    
    
end # end of class
