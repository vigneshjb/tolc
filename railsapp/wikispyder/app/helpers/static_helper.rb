require "net/http"
require 'nokogiri'

include ApplicationHelper

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
			if (link!=nil && !link.start_with?("/wiki/File:") && link.index(':') == nil && link.index('%') == nil && link.start_with?("/wiki/"))
				required_link.push("https://en.wikipedia.org" + link)
			end
		end

		if(required_link.length()>80) 
			retdata=required_link[50..100] 
		else 
			retdata=required_link
		end

		return retdata
	end

	def hash_interest(user)
    	hash_to_return = {}
	    user.interest.split(',').each {|int| hash_to_return[ApplicationHelper::INTEREST_HASH[int.to_i]] = int.to_i }
	    return hash_to_return
	end

end
