module LazyGoogleAnalytics
  class Auth

    attr_accessor :analytics, :client

    def initialize
      config = LazyGoogleAnalytics::Config
      @key = Google::APIClient::PKCS12.load_key(config.key_file, config.pass_phrase)
      @asserter = Google::APIClient::JWTAsserter.new( config.email, config.scope, @key)
    end

    def authorize
      config = LazyGoogleAnalytics::Config
      @client = Google::APIClient.new(application_name: config.application_name,application_version: config.application_version)
      @client.authorization = @asserter.authorize()
      @analytics = @client.discovered_api("analytics",'v3')
    end

  end
end

