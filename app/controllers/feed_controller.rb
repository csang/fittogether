class FeedController < ApplicationController

  before_action :get_account  # will return @account
  respond_to :html, :js, :json
 

  def index
    @data = (session[:account].present?) ? session[:account] : nil;
    @profile = 'feed'
    @posts = Post.where(:status=>1).order("id DESC")
 
   
  end
  
  def create_post
  #abort(params.inspect)
   if request.xhr?   
  #abort(params[:feed][:share_with].inspect)
	    @post =  Post.create(:account_id=>@account.id,:text=>params[:post],:image=>params[:photo],:video=>params[:video], :status=>1,:share_with=>params[:feed][:share_with])	        
	#abort(@post.inspect)
		  respond_to do |format|
		  format.js 		  
		 # format.html 		  
		 end
	end
  
  end
  
  
  def create_comment
  #render :layout => false
    if request.xhr?    
    
      @comment =  Comment.create(:account_id=>@account.id,:text=>params[:text],:post_id=>params[:post],:status=>1)
	 
     respond_to do |format|
      format.js       
     end
    
    end
  
  end
  
   def create_album
	    album =  Album.create(:account_id => @account.id)
	    if album
	  		@image =  AlbumImage.create(:album_id=>album.id, :image=> params[:album])
	  		
			if @image
				redirect_to :action => "show_album", :id => album.id
			end 
		else
			  redirect_to request.env['HTTP_REFERER'] and return
	    end 	        
	
	end
  
  
  
    
   def show_album
    @profile = 'album'
	@album = Album.where(:id=>params[:id] ,:account_id=>@account.id).first
	if !@album.present?
		flash[:notice] = "Album does not exist."  
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
          AlbumImage.create(:album_id=>id, :image=> image)
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
end # end of class
