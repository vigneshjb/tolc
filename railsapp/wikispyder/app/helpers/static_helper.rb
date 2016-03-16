require "net/http"
require 'nokogiri'

module StaticHelper

	def make_request(url)
		uri = URI(url)
		http = Net::HTTP.new(uri.host, uri.port)
		http.use_ssl = true
		http.verify_mode = OpenSSL::SSL::VERIFY_NONE
		response = http.get(uri.request_uri)
		return response.body
	end

	def getfullurl(body)
		response_json = JSON.parse(body)
		return response_json["query"]["pages"].first[1]["fullurl"]
	end

	def crawler(url)
		result = "I think the GET failed :(.. I'm confused"
		result = make_request(url) unless url==nil
		html_doc = Nokogiri::HTML(result)
		all_links = html_doc.css('a').map { |link| link['href']}
		required_link = []
		all_links.delete("#")
		all_links.each_with_index do |link, index| 
			if (link!=nil && !link.start_with?("#"))
				required_link.push(link)
			end
		end
		return required_link
	end

end
