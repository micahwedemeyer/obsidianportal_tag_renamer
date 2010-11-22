file_name = File.join(Rails.root, "config", "oauth.yml")
settings = YAML.load(ERB.new(File.new(file_name).read).result)[Rails.env].symbolize_keys

OAUTH_CONSUMER_KEY = settings[:consumer_key]
OAUTH_CONSUMER_SECRET = settings[:consumer_secret]
