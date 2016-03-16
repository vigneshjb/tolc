require "net/http"

class StaticController < ApplicationController
  def index
  end

  def search
  end

  def proxy
  	url_entry = params[:method] == "1" ? "https://en.wikipedia.org/w/api.php?action=query&"+
  									"format=json&prop=info&inprop=url&titles="+params[:data] : ""

  	uri = URI(url_entry)
	http = Net::HTTP.new(uri.host, uri.port)
	http.use_ssl = true
	http.verify_mode = OpenSSL::SSL::VERIFY_NONE
	response = http.get(uri.request_uri)
	p response.body
	render :text => response.body
  end

end