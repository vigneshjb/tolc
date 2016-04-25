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

  def getUserName(id)
    return User.find(id).name
  end

  def getWikiURLS(viewChain)
    viewItems = viewChain.split(',')
    urlString = ""
    viewItems.each { |item| urlString += "<a href=\"https://en.wikipedia.org/wiki/"+item.gsub(' ','_')+"\">"+item+"</a>" +" > " }
    urlString[0..-3]
  end

end