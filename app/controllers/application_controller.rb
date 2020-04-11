class ApplicationController < ActionController::API
    before_action :set_current_user

    def issue_token(payload)
        JWT.encode(payload, ENV["RAILS_SECRET"])
    end

    def decode_token(token)
        JWT.decode(token, ENV["RAILS_SECRET"])[0]
    end

    def get_token
        request.headers["Authorization"] || request.headers["Authorisation"]
    end

    def set_current_user
        token = get_token
        if token && token != "null"
            decoded_token = decode_token(token)
            @current_user = User.find(decoded_token["user_id"])
        else
            @current_user = nil
        end
    end

    def logged_in?
        !!@current_user
    end

    def artsy_token
        api_url = URI.parse('https://api.artsy.net/api/tokens/xapp_token')
        response = Net::HTTP.post_form(api_url, client_id: ENV["ARTSY_CLIENT_ID"], client_secret: ENV["ARTSY_CLIENT_SECRET"])
        xapp_token = JSON.parse(response.body)['token']
    end
    
end
