require 'learn_web/client/user/me'

module LearnWeb
  class Client
    module User
      def me_endpoint
        "#{API_ROOT}/users/me"
      end

      def me
        response = @conn.get do |req|
          req.url me_endpoint
          req.headers['Authorization'] = "Bearer #{token}"
        end

        LearnWeb::Client::User::Me.new(response, silent_output: silent_output)
      end
    end
  end
end
