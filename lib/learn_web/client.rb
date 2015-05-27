module LearnWeb
  class Client
    attr_reader :token, :conn, :silent_output

    LEARN_URL = 'https://learn.co'
    API_ROOT  = '/api/v1'

    include LearnWeb::Client::PullRequest
    include LearnWeb::Client::Lesson
    include LearnWeb::Client::ValidateRepo
    include LearnWeb::Client::Fork
    include LearnWeb::Client::User

    def initialize(token:, silent_output: false)
      @token = token
      @silent_output = silent_output
      @conn = Faraday.new(url: LEARN_URL) do |faraday|
        faraday.adapter Faraday.default_adapter
      end
    end

    def valid_token?
      !!me.data
    end
  end
end
