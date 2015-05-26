require 'faraday'

module LearnWeb
  class Client
    attr_reader :token, :conn, :silent_output

    LEARN_URL = 'https://learn.co'
    API_ROOT  = '/api/v1'

    def initialize(token:, silent_output: false)
      @token = token
      @silent_output = silent_output
      @conn = Faraday.new(url: LEARN_URL) do |faraday|
        faraday.adapter Faraday.default_adapter
      end
    end

    def me_endpoint
      "#{API_ROOT}/users/me"
    end

    def pr_endpoint
      "#{API_ROOT}/lesson_submissions"
    end

    def current_lesson_endpoint
      "#{API_ROOT}/users/current_lesson"
    end

    def validate_repo_slug_endpoint
      "#{API_ROOT}/users/validate_repo_slug"
    end

    def me
      response = @conn.get do |req|
        req.url me_endpoint
        req.headers['Authorization'] = "Bearer #{token}"
      end

      LearnWeb::Client::Me.new(response, silent_output: silent_output)
    end

    def issue_pull_request(repo_name:, branch_name:)
      response = @conn.post do |req|
        req.url pr_endpoint
        req.headers['Authorization'] = "Bearer #{token}"
        req.params['repo_name'] = repo_name
        req.params['branch_name'] = branch_name
      end

      LearnWeb::Client::PullRequestResponse.new(response)
    end

    def current_lesson
      response = @conn.get do |req|
        req.url current_lesson_endpoint
        req.headers['Authorization'] = "Bearer #{token}"
      end

      LearnWeb::Client::CurrentLesson.new(response)
    end

    def validate_repo_slug(repo_slug:)
      response = @conn.post do |req|
        req.url validate_repo_slug_endpoint
        req.headers['Authorization'] = "Bearer #{token}"
        req.params['repo_slug'] = repo_slug
      end

      LearnWeb::Client::ValidateLesson.new(response)
    end

    def valid_token?
      !!me.data
    end
  end
end
