require 'json'

module LearnWeb
  class Client
    module User
      class Response
        attr_reader :body, :status

        def initialize(status:, body:)
          @status = status
          @body   = body
        end
      end

      class Users
        attr_accessor :response, :data, :silent_output, :users

        include LearnWeb::AttributePopulatable

        def initialize(response, silent_output: false)
          @response      = response
          @silent_output = silent_output

          parse!
        end

        def parse!
          if response.status == 200
            self.data = Oj.load(response.body, symbol_keys: true)

            populate_users!
          elsif silent_output == false
            case response.status
            when 401
              puts "It seems your OAuth token is incorrect. Please re-run config with: learn reset"
              exit 1
            when 500
              puts "Something went wrong. Please try again."
              exit 1
            else
              puts "Something went wrong. Please try again."
              exit 1
            end
          end

          self
        end

        def to_a
          self.users.map(&:data)
        end

        private

        def populate_users!
          populate_attributes!

          self.users.map! do |user_data|
            user_response = Response.new(status: response.status, body: user_data.to_json)

            LearnWeb::Client::User::User.new(user_response)
          end
        end
      end
    end
  end
end
