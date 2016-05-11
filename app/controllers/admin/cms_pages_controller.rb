class Admin::CmsPagesController < ApplicationController
  #before_action :set_admin_cms_page, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_admin!
  layout "admin"

  # GET /admin/cms_pages
  # GET /admin/cms_pages.json
  def index
    @admin_cms_pages = CmsPage.order('id desc').paginate(page: params[:page], per_page: 10)
  end

  # GET /admin/cms_pages/1
  # GET /admin/cms_pages/1.json
  def show
     
    @admin_cms_pages = CmsPage.find(params[:id])
 
    if !@admin_cms_pages.blank?	
      respond_to do |format|
        format.html
        format.json { render json: @admin_cms_pages }
      end
    else
      redirect_to action: 'index'
    end
  end

  # GET /admin/cms_pages/new
  def new
    @cms_page = CmsPage.new
  end

  # GET /admin/cms_pages/1/edit
  def edit
     @cms_page = CmsPage.find(params[:id])
    render 'edit'
  end

  # POST /admin/cms_pages
  # POST /admin/cms_pages.json
  def create
   
    @admin_cms_page = CmsPage.new(admin_cms_page_params)

    respond_to do |format|
      if @admin_cms_page.save
        flash[:notice]=  'Cms page was successfully created.'
        format.html { redirect_to admin_cms_page_path(@admin_cms_page.id) }
        format.json { render :show, status: :created, location: admin_cms_page_url }
      else
        flash[:error] = "Could not be updated. Please try again."
        redirect_to request.env['HTTP_REFERER'] and return
      end
    end
  end

  # PATCH/PUT /admin/cms_pages/1
  # PATCH/PUT /admin/cms_pages/1.json
  def update
    @admin_cms_page = CmsPage.find(params[:id])
    if @admin_cms_page.present?
    if  @admin_cms_page
      respond_to do |format|
        if @admin_cms_page.update(admin_cms_page_params)
           flash[:notice]=  'Cms page was successfully updated.'
          format.html { redirect_to admin_cms_page_path(@admin_cms_page.id)  }
          format.json { render :show, status: :ok, location: admin_cms_page_url }
        else
          flash[:error] = "Could not be updated. Please try again."
          redirect_to request.env['HTTP_REFERER'] and return
        end
    end
    end
  end
  end

  # DELETE /admin/cms_pages/1
  # DELETE /admin/cms_pages/1.json
  def destroy
 
    @admin_cms_pages = CmsPage.find(params[:id])
    if @admin_cms_pages.present?
     if  @admin_cms_pages.destroy
      respond_to do |format|
         flash[:notice]=  'Cms page was successfully destroyed.'
        format.html { redirect_to action: 'index'}       
      end
     else 
        format.html { redirect_to action: 'index', alert: 'Please try again.' }   
     end 
    else 
       redirect_to action: 'index'
    end
  end
  
   def search

      @admin_cms_pages = CmsPage.where("lower(name) LIKE ? OR lower(meta_title) LIKE ? OR lower(seo_url) LIKE ? OR lower(meta_keyword) LIKE ? OR lower(meta_desc) LIKE ?", "%#{params[:search]}%","%#{params[:search]}%","%#{params[:search]}%","%#{params[:search]}%","%#{params[:search]}%" ).paginate(
        page: params[:page])
	end
	

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_cms_page
      @admin_cms_page = CmsPage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_cms_page_params
      params[:cms_page].permit(:name,:content, :meta_title, :seo_url, :meta_desc, :meta_keyword, :status, :show_in_footer)
    end
end
