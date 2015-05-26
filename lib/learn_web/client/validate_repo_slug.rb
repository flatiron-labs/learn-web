module LearnWeb
  class Client
    class ValidateRepoSlug
      attr_accessor :data, :repo_slug
      attr_reader   :response

      include AttributePopulatable

      def initialize(response)
        @response = response

        parse!
      end

      private

      def parse!
        case response.status
        when 200
          self.data = Oj.load(response.body, symbol_keys: true)
          populate_attributes!
        when 401
          puts "It seems your OAuth token is incorrect. Please re-run config with: learn reset"
          exit
        when 500
          puts "Something went wrong. Please try again."
          exit
        else
          puts "Something went wrong. Please try again."
          exit
        end
      end
    end
  end
end
