class Api::BodyMeasurementsController < ApplicationController
	before_action :get_account
  def show
    @body = Fitbit::BodyMeasurements.new @account
# abort(@body.fatgoal.inspect) 
  end
end
