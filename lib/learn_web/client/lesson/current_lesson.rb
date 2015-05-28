module LearnWeb
  class Client
    module Lesson
      class CurrentLesson
        attr_reader   :response
        attr_accessor :data, :id, :title, :link, :github_repo, :forked_repo,
                      :assessments, :lab

        include LearnWeb::AttributePopulatable

        def initialize(response)
          @response = response

          parse!
        end

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
            puts "Something when wrong. Please try again."
            exit
          end

          self
        end
      end
    end
  end
end
