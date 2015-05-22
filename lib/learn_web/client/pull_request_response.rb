require 'oj'

module LearnWeb
  class Client
    class PullRequestResponse
      attr_accessor :message, :status
      attr_reader   :data

      def initialize(response_data)
        @data = response_data

        parse!
      end

      private

      def parse!
        self.status = data.status

        begin
          body = Oj.load(data.body, symbol_keys: true)
          self.message = body[:message]
        rescue
          self.message = 'Sorry, something went wrong. Please try again.'
        end
      end
    end
  end
end
