class MainController < ApplicationController
  skip_before_filter :login_required, :only => [:index]
  
  def index
    if logged_in?
    else
      @request_token = consumer.get_request_token(:oauth_callback => campaigns_url)
      session[:request_token] = @request_token
      @authorize_url = @request_token.authorize_url
    end
  end
  
  def logout
    reset_session
    
    redirect_to root_path
  end
end
