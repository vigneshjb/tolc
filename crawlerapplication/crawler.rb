require 'net/http'
require 'nokogiri'

def crawler(url)
	uri = URI(url)
	result = "I think the GET failed :(.. I'm confused"
	result = Net::HTTP.get(uri) unless url==nil
	html_doc = Nokogiri::HTML(result)
	all_links = html_doc.css('a').map { |link| link['href']}
	required_link = []
	all_links.delete("#")
	all_links.each_with_index do |link, index| 
		if (link!=nil && !link.start_with?("#"))
			required_link.push(link)
		end
	end
	required_link.each { |link| p link}
end

#crawler("https://en.wikipedia.org/wiki/Computer_science")
crawler(ARGV[0])
