require 'learn_web/client/event/submission'

module LearnWeb
  class Client
    module Event
      attr_reader :client

      IRONBROKER_URL = ''

      def client
        @client ||= Faraday.new(url: IRONBROKER_URL) do |faraday|
          faraday.adapter Faraday.default_adapter
        end
      end

      def submission_endpoint
        "#{IRONBROKER_URL}"
      end

      def submit_event(params)
        response = post(
          submit_event,
          params: params,
          client: client
        )

        LearnWeb::Client::Fork::Request.new(response)
      end
    end
  end
end
