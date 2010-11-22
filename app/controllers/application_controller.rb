class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :login_required
  
  protected
  
  def logged_in?
    !(session[:access_token_secret] && session[:access_token_key]).nil?
  end
  helper_method :logged_in?
  
  def login_required
    unless logged_in?
      redirect_to root_path
      return false
    end
    true
  end
  
  def consumer    
    @consumer ||= OAuth::Consumer.new(OAUTH_CONSUMER_KEY, OAUTH_CONSUMER_SECRET, {
      :site => "http://api.obsidianportal.com",
      :scheme => :header,
      :http_method => :post,
      :request_token_url => "https://www.obsidianportal.com/oauth/request_token",
      :access_token_url => "https://www.obsidianportal.com/oauth/access_token",
      :authorize_url => "https://www.obsidianportal.com/oauth/authorize"
    })
  end
  
  def access_token
    @access_token ||= OAuth::AccessToken.new(consumer, session[:access_token_key], session[:access_token_secret])
  end
end
