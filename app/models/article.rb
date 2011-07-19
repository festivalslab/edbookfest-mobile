module HTTParty
  class Parser
    def json
      MultiJson.decode(body)
    end
  end
end

class Article
  include HTTParty
  base_uri 'content.guardianapis.com'
  
  def self.search(term)
    query = {
      :format => "json",
      :"api-key" => ENV["EIBF_GUARDIAN_API"],
      :section => %w{books childrens-books-site}.join("|"),
      :"show-fields" => %w{headline trailText shortUrl standfirst thumbnail byline publication}.join(","),
      :"page-size" => 25,
      :q => term
    }
    res = get('/search', :query => query)
    if res && res['response'] && res['response']['results'] then 
      res['response']['results'] 
    else 
      [] 
    end
  end
  
  def self.find(id)
    query = {
     :format => "json",
     :"api-key" => ENV["EIBF_GUARDIAN_API"],
     :"show-fields" => "all"
    }
    res = get("/#{id}", :query => query)
    if res && res['response'] && res['response']['content'] then
      res['response']['content']
    else
      nil
    end
  end
end