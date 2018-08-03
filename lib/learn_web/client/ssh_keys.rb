require 'learn_web/client/ssh_keys/add'
puts 'loaded'

module LearnWeb
  class Client
    module SshKeys
      def add_ssh_key_endpoint
        "#{API_ROOT}/ssh_keys"
      end

      def add_ssh_key(key:, key_title: nil)
        response = post(
          add_ssh_key_endpoint,
          headers: { 'Authorization' => "Bearer #{token}" },
          params: { 'key' => key, key_title: key_title }.compact
        )

        LearnWeb::Client::SshKeys::Add.new(response).parse!
      end
    end
  end
end
