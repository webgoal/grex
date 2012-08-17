Rails.application.config.middleware.use OmniAuth::Builder do
  keys = YAML.load_file("#{RAILS_ROOT}/config/provider_keys.yml")
  provider :twitter, keys['twitter']['consumer_key'], keys['twitter']['consumer_secret']
  provider :facebook, keys['facebook']['consumer_key'], keys['facebook']['consumer_secret']
end

