include StaticHelper

class StaticController < ApplicationController
  def index
  end

  def search
  end

  def proxy
  	url = "https://en.wikipedia.org/w/api.php?action=query&"+
  		  "format=json&prop=info&inprop=url&titles="+params[:data]

  	full_url = StaticHelper.getfullurl(StaticHelper.make_request(url))
	  render :json => {"links" => StaticHelper.crawler(full_url), "page_url"=>full_url}
  end

end