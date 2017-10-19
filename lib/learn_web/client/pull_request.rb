require 'learn_web/client/pull_request/response'

module LearnWeb
  class Client
    module PullRequest
      def pr_endpoint
        "#{API_ROOT}/lesson_submissions"
      end

      def issue_pull_request(repo_name:, branch_name:, message: nil, additional_params: {})
        response = post(
          pr_endpoint,
          headers: { 'Authorization' => "Bearer #{token}" },
          params: {
            'repo_name' => repo_name,
            'branch_name' => branch_name,
            'message' => message
          }.merge(additional_params)
        )

        LearnWeb::Client::PullRequest::Response.new(response)
      end
    end
  end
end
