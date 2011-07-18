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
end