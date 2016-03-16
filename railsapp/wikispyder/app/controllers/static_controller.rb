include StaticHelper

class StaticController < ApplicationController
  def index
  end

  def search
  end

  def proxy
  	url = params[:method] == "1" ? "https://en.wikipedia.org/w/api.php?action=query&"+
  									"format=json&prop=info&inprop=url&titles="+params[:data] : ""

  	response = StaticHelper.make_request(url)
	render :text => StaticHelper.crawler(StaticHelper.getfullurl(response))
  end

end