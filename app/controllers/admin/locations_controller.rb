class Admin::LocationsController < ApplicationController
     before_filter :authenticate_admin!
	layout "admin"

  # GET /admin/locations
  # GET /admin/locations.json
  def index
    @admin_locations = State.order('name asc').paginate(page: params[:page], per_page: 10)
   
  end

  # GET /admin/locations/1
  # GET /admin/locations/1.json
  def show
     @admin_locations = State.find(params[:id])
 
    if !@admin_locations.blank?	
      respond_to do |format|
        format.html
        format.json { render json: @admin_locations }
      end
    else
      redirect_to action: 'index'
    end
  end

  # GET /admin/locations/new
  def new  
    @admin_location = 'location'
  end

  # GET /admin/locations/1/edit
  def edit
 
     @admin_location = State.find(params[:id])
    render 'edit'
  end

  # POST /admin/locations
  # POST /admin/locations.json
  def add_city
    
    @admin_location = City.new(admin_location_params)
    respond_to do |format|
      if @admin_location.save
        state_id = State.where(:state_code =>params[:location][:state_code]).first
        flash[:notice]=  'City was successfully added.'
        format.html { redirect_to admin_location_path(state_id[:id]) }
       
      else
       
        flash[:alert] = 'Please Try again.'
        redirect_to request.env['HTTP_REFERER'] and return
      end
    end
  end

  # PATCH/PUT /admin/locations/1
  # PATCH/PUT /admin/locations/1.json
  def update
    respond_to do |format|
      if @admin_location.update(admin_location_params)
        format.html { redirect_to @admin_location, notice: 'Location was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_location }
      else
        format.html { render :edit }
        format.json { render json: @admin_location.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_city
    
    if request.xhr?
      @admin_location = City.find(params[:id])
       if @admin_location.update(:name => params[:name])           
        render json: 1
       else
         render json: 0
       end
 
    end
    
  end
  
    def delete_city
    
    if request.xhr?
      @admin_location = City.find(params[:id])
       if @admin_location.destroy     
        render json: 1
       else
         render json: 0
       end
 
    end
    
  end
  # DELETE /admin/locations/1
  # DELETE /admin/locations/1.json
  def destroy
    @admin_location.destroy
    respond_to do |format|
      format.html { redirect_to admin_locations_url, notice: 'Location was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
    def search

      @admin_locations = State.where("lower(name) LIKE ? OR lower(state_code) LIKE ?" ,"%#{params[:search]}%","%#{params[:search]}%" ).paginate(
        page: params[:page], per_page: 10)
	end
	

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_location
      @admin_location = Admin::Location.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_location_params
      params.require(:location).permit(:name, :state_code)
    end
end
