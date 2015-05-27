module LearnWeb
  class Client
    module Fork
      def fork_endpoint
        "#{API_ROOT}/fork_requests"
      end

      def fork_repo(repo_name:)
        response = @conn.post do |req|
          req.url fork_endpoint
          req.headers['Authorization'] = "Bearer #{token}"
          req.params['repo_name'] = repo_name
        end

        LearnWeb::Client::Fork::Request.new(response)
      end
    end
  end
end
