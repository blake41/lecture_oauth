class Requester

  URL4 = "https://api.twitter.com/1.1/statuses/mentions_timeline.json"

  def initialize(id)
    @user = User.find(id)
  end

  def make_request
    access_token = self.prepare_access_token
    response = access_token.request(:get, URL4)
    parsed_response = JSON.parse(response.body)
  end

  def prepare_access_token
    consumer = OAuth::Consumer.new(ENV["CONSUMER_KEY"],ENV["CONSUMER_SECRET"],
      { :site => "https://api.twitter.com",
        :scheme => :header
      })
    # now create the access token object from passed values
    token_hash = { :oauth_token => @user.token,
                   :oauth_token_secret => @user.secret
                 }
    access_token = OAuth::AccessToken.from_hash(consumer, token_hash )
    return access_token
  end

end