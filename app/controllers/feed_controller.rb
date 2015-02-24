class FeedController < ApplicationController

  before_action :get_account # will return @account

  def index
    @data = (session[:account].present?) ? session[:account] : nil;
  end
end
