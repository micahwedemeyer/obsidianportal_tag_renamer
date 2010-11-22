class TagsController < ApplicationController
  
  def update
    campaign_id = params[:campaign_id]
    old_tag = params[:old_tag]
    new_tag = params[:new_tag]
    
    @campaign = JSON.parse(access_token.get("/v1/campaigns/#{campaign_id}.json").body)
    @wiki_pages = JSON.parse(access_token.get("/v1/campaigns/#{campaign_id}/wikis.json").body)
    
    @wiki_pages.each do |wp|
      tag_list = wp['tags']
      if tag_list.include?(old_tag)
        tag_list.delete(old_tag)
        tag_list << new_tag
        
        attrs = {
          :wiki_page => {
            :tags => tag_list
          }
        }
        
        logger.info "Updating: #{wp['id']}"
        resp = access_token.put("/v1/campaigns/#{campaign_id}/wikis/#{wp['id']}.json", attrs.to_json)
        
        if resp.is_a?(Net::HTTPSuccess)
          logger.info "Success"
        else
          logger.info "Fail"
        end
      end
    end
    
    redirect_to campaign_path(:id => campaign_id)
  end
end
