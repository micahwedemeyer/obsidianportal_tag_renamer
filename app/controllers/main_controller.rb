class MainController < ApplicationController
  
  def index
    if logged_in?
    else
      @request_token = consumer.get_request_token(:oauth_callback => campaigns_url)
      session[:request_token] = @request_token
      @authorize_url = @request_token.authorize_url
    end
  end
end
