require 'learn_web/client/event/submission'

module LearnWeb
  class Client
    module Event
      attr_reader :client

      #IRONBROKER_URL = 'http://ironbroker-v2.flatironschool.com'
      IRONBROKER_URL = 'http://localhost:9292'

      def client
        @client ||= Faraday.new(url: IRONBROKER_URL) do |faraday|
          faraday.adapter Faraday.default_adapter
        end
      end

      def submission_endpoint
        '/e/learn_gem'
      end

      def submit_event(params)
        response = post(
          submit_event,
          params: params,
          client: client
        )

        LearnWeb::Client::Event::Submission.new(response)
      end
    end
  end
end
