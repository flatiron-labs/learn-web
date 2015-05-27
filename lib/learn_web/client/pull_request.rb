module LearnWeb
  class Client
    module PullRequest
      def pr_endpoint
        "#{API_ROOT}/lesson_submissions"
      end

      def issue_pull_request(repo_name:, branch_name:)
        response = @conn.post do |req|
          req.url pr_endpoint
          req.headers['Authorization'] = "Bearer #{token}"
          req.params['repo_name'] = repo_name
          req.params['branch_name'] = branch_name
        end

        LearnWeb::Client::PullRequest::Response.new(response)
      end
    end
  end
end
