module ApplicationHelper

  INTEREST_HASH = { 1=>"Computer Science", 2=>"Sanskrit", 3=>"Mathematics", 4=>"Zoology", 5=>"History" }
  HASH_INTEREST = { "Computer Science"=>1, "Sanskrit"=>2, "Mathematics"=>3, "Zoology"=>4, "History"=>5 }

  # Returns the full title on a per-page basis.       # Documentation comment
  def full_title(page_title = '')                     # Method def, optional arg
    base_title = "WikiSpyder"                         # Variable assignment
    if page_title.empty?                              # Boolean test
      base_title                                      # Implicit return
    else
      page_title + " | " + base_title                 # String concatenation
    end
  end

  def getcontent(feed)
    return_html=""
    if feed.feed_type == "view"
      return_html = "<h4><strong>" + getUserName(feed.user_id) + "</strong> has Viewed <code>" + 
                    getViewedView(feed.feed_content) + "</code></h4> <p class='text-right'> <small>" + 
                    " This is shown because of your interest in <strong>" + 
                    ApplicationHelper::INTEREST_HASH[feed.interest] + "</strong></small></p>"
    elsif feed.feed_type == "request_edit"
      return_html = "<h4><strong>" + getUserName(feed.user_id) + "</strong> has requested an edit on the wiki<code>" + 
                    getWikiLink(feed.feed_content) + "</code></h4> <p class='text-right'> <small>" + 
                    " This is shown because of your interest in <strong>" + 
                    ApplicationHelper::INTEREST_HASH[feed.interest] + "</strong></small></p>"
    else
      return_html = "<h4><strong>" + getUserName(feed.user_id) + "</strong> has suggested content for the wiki <code>" + 
                    getWikiLink(JSON.parse(feed.feed_content)["page"]) + "</code><br><br><pre>" + 
                    JSON.parse(feed.feed_content)["content"] + "</pre></h4> <p class='text-right'> <small>" + 
                    " This is shown because of your interest in <strong>" + 
                    ApplicationHelper::INTEREST_HASH[feed.interest] + "</strong></small></p>"

    end
    return return_html
  end

  def getUserName(id)
    return User.find(id).name.titleize
  end

  def getViewedView(viewChain)
    viewItems = viewChain.split(',')
    urlString = ""
    viewItems.each { |item| urlString += "<a href=\"https://en.wikipedia.org/wiki/"+item.gsub(' ','_')+"\">"+item.titleize+"</a>" +" > " }
    urlString[0..-3]
  end

  def getWikiLink(pageName)
    "<a href=\"https://en.wikipedia.org/wiki/"+pageName.gsub(' ','_')+"\">"+pageName.titleize+"</a>"
  end

end