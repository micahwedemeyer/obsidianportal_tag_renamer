class CampaignsController < ApplicationController
  skip_before_filter :login_required, :only => [:index]
  
  def index
    if params[:oauth_verifier]
      @request_token = session[:request_token]
      token = @request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
      session[:access_token_key] = token.token
      session[:access_token_secret] = token.secret
      
      logger.info("Access Authorized")
    elsif !logged_in?
      redirect_to root_path
      return
    end
    
    @me = JSON.parse(access_token.get('/v1/users/me.json').body)
    
    @campaigns = @me['campaigns']
  end
  
  def show
    campaign_id = params[:id]
    
    @campaign = JSON.parse(access_token.get("/v1/campaigns/#{campaign_id}.json").body)
    @wiki_pages = JSON.parse(access_token.get("/v1/campaigns/#{campaign_id}/wikis.json").body)
    @characters = JSON.parse(access_token.get("/v1/campaigns/#{campaign_id}/characters.json").body)
    
    entities = @wiki_pages + @characters
    
    @tags_with_counts = {}
    entities.each do |ent|
      tag_list = ent['tags']
      tag_list.each do |t|
        if @tags_with_counts.has_key?(t)
          @tags_with_counts[t] = @tags_with_counts[t] + 1
        else
          @tags_with_counts[t] = 1
        end
      end
    end
  end
end
