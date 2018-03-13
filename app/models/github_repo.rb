class GithubRepo

  attr_reader :name, :url

    def initialize(hash)
      @name = hash["name"]
      @url = hash["html_url"]
    end

    def authenticate!(client_id, client_secret, code)
      response = Faraday.post "https://github.com/login/oauth/access_token", {client_id: ENV["GITHUB_CLIENT_ID"], client_secret: ENV["GITHUB__CLIENT_SECRET"],code: params[:code]}, {'Accept' => 'application/json'}
      access_hash = JSON.parse(response.body)
      session[:token] = access_hash["access_token"]

      user_response = Faraday.get "https://api.github.com/user", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
      user_json = JSON.parse(user_response.body)
      session[:username] = user_json["login"]

      redirect_to '/'
    end

  end
