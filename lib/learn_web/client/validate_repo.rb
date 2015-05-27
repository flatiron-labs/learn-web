module LearnWeb
  class Client
    module ValidateRepo
      def validate_repo_slug_endpoint
        "#{API_ROOT}/repo_slug_validations"
      end

      def validate_repo_slug(repo_slug:)
        response = @conn.post do |req|
          req.url validate_repo_slug_endpoint
          req.headers['Authorization'] = "Bearer #{token}"
          req.params['repo_slug'] = repo_slug
        end

        LearnWeb::Client::ValidateRepo::Slug.new(response)
      end
    end
  end
end
