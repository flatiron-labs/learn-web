module LearnWeb
  class Client
    module Lesson
      def current_lesson_endpoint
        "#{API_ROOT}/users/current_lesson"
      end

      def current_lesson
        response = @conn.get do |req|
          req.url current_lesson_endpoint
          req.headers['Authorization'] = "Bearer #{token}"
        end

        LearnWeb::Client::Lesson::CurrentLesson.new(response)
      end
    end
  end
end
