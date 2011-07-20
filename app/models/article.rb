module HTTParty
  class Parser
    def json
      MultiJson.decode(body)
    end
  end
end

class Article
  include HTTParty, Exceptions
  base_uri 'content.guardianapis.com'
  default_params :format => "json", :"api-key" => ENV["EIBF_GUARDIAN_API"]
  
  def self.search(term)
    query = {
      :section => %w{books childrens-books-site}.join("|"),
      :"show-fields" => %w{headline trailText shortUrl standfirst thumbnail byline publication}.join(","),
      :"page-size" => 25,
      :q => term
    }
    res = get('/search', :query => query)
    raise GuardianApiError if is_error(res)
    (res && res['response'] && res['response']['results']) ? res['response']['results'] : []
  end
  
  def self.find(id)
    query = {
     :"show-fields" => "all"
    }
    res = get("/#{id}", :query => query)
    raise GuardianApiError if is_error(res)
    (res && res['response'] && res['response']['content']) ? res['response']['content'] : nil
  end
  
private
  
  def self.is_error(res)
    res && res['response'] && res['response']['status'] == "error"
  end

end