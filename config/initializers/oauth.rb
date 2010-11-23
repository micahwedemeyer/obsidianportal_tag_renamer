# Allow for environment settings. Useful for heroku deployment
if ENV['OAUTH_CONSUMER_KEY'] && ENV['OAUTH_CONSUMER_SECRET']
  OAUTH_CONSUMER_KEY = ENV['OAUTH_CONSUMER_KEY']
  OAUTH_CONSUMER_SECRET = ENV['OAUTH_CONSUMER_SECRET']
else
  file_name = File.join(Rails.root, "config", "oauth.yml")
  settings = YAML.load(ERB.new(File.new(file_name).read).result)[Rails.env].symbolize_keys

  OAUTH_CONSUMER_KEY = settings[:consumer_key]
  OAUTH_CONSUMER_SECRET = settings[:consumer_secret]
end
