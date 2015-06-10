require 'learn_web/client/environment/setup_list'

module LearnWeb
  class Client
    module Environment
      def environment_setup_list_endpoint
        "#{API_ROOT}/environmentalizer/steps"
      end

      def environment_setup_list
        response = @conn.get do |req|
          req.url environment_setup_list_endpoint
        end

        LearnWeb::Client::Environment::SetupList.new(response)
      end
    end
  end
end
