require 'httparty'

class OrcidApi
  def getAccessToken
    result = HTTParty.post("https://orcid.org/oauth/token",
                           :body => {:client_id => '0000-0000-0000-8261',
                                     :client_secret => 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
                                     :scope => '/webhook',
                                     :grant_type => 'client_credentials'
                           },
                           :headers => {'Accept' => 'application/json'})
    result.parsed_response["access_token"]
  end

  def register(orcid, access_token)
    url = "https://api.orcid.org/#{orcid}/webhook/encoded-customized-url"
    puts url
    result = HTTParty.put(url,
                          :headers => {'Accept' => 'application/json',
                                       'Authorization' => "Bearer #{access_token}",
                                       'Content-Type' => 'application/json'})
    puts result.code
    result.code
  end

  def unregister(orcid, access_token)
    url = "https://api.orcid.org/#{orcid}/webhook/encoded-customized-url"
    puts url
    result = HTTParty.delete(url,
                          :headers => {'Accept' => 'application/json',
                                       'Authorization' => "Bearer #{access_token}",
                                       'Content-Type' => 'application/json'})
    puts result.code
    result.code
  end
end
