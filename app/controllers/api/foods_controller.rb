class Api::FoodsController < ApplicationController
before_action :get_account
  def index
    @foods = []
   
      @foods = Fitbit::Food.search(@account,'Coppa')
      abort(@foods.inspect)
    
  end
end
