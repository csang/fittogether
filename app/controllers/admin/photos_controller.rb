# Controller to manage users
class Admin::PhotosController < ApplicationController
  # include AccountsHelper
  before_filter :authenticate_admin!
  layout "admin"

 
 
  # Show details 
  def show
    @album = Album.find(params[:id])
    if !@album.blank?	
      respond_to do |format|
        format.html
        format.json { render json: @album }
      end
    else
      redirect_to action: 'index'
    end
    
  end


  # Delete a user
  def destroy
    if params[:model] == 'Album'
      @model = Album
    else
      @model = AlbumImage
    end
    @photo = @model.where(:id => params[:id]).first
      if @photo.destroy
        redirect_to listPhotos_admin_photos_url
      else
        redirect_to admin_photo_url
      end 
    
  end
  
  
  def search
     !@albums = Album.where("lower(title) LIKE ?", "%#{params[:search]}%").paginate(page: params[:page])
	end
	
	
	# List based on type of users
  def listPhotos   
    @albums =  Album.order('id').paginate(page: params[:page], per_page: 10)
    render :index
  end
 
end
