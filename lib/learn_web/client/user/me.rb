module LearnWeb
  class Client
    module User
      class Me
        attr_accessor :response, :silent_output, :data_object

        def initialize(response, silent_output: false)
          @response      = response
          @silent_output = silent_output

          parse!
        end

        def parse!
          self.data_object = LearnWeb::Client::User::User.new(response, silent_output: silent_output)

          self
        end

        def method_missing(name, *args, &block)
          self.data_object.send(name, *args, &block)
        end
      end
    end
  end
end
