require 'learn_web/client/user/user'
require 'learn_web/client/user/users'
require 'learn_web/client/user/me'

module LearnWeb
  class Client
    module User
      def me_endpoint
        "#{API_ROOT}/users/me"
      end

      def users_endpoint
        "#{API_ROOT}/users"
      end

      def me
        response = get(
          me_endpoint,
          headers: { 'Authorization' => "Bearer #{token}" }
        )

        LearnWeb::Client::User::Me.new(response, silent_output: silent_output)
      end

      def users(fields:, page: nil, per_page: nil)
        response = get(
          users_endpoint,
          headers: { 'Authorization' => "Bearer #{token}" },
          params:  { 'fields' => fields, page: page, per_page: per_page }
        )

        LearnWeb::Client::User::Users.new(response, silent_output: silent_output).to_a
      end
    end
  end
end
