module LearnWeb
  class Client
    module Event
      class Submission
        attr_reader :response

        include LearnWeb::AttributePopulatable
        include LearnWeb::ResponseParsable

        def initialize(response)
          @response = response

          parse!
        end
      end
    end
  end
end
