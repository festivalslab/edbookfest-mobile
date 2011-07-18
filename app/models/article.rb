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
    get('/search', :query => query)['response']['results']
  end
end