Rails.application.config.middleware.use OmniAuth::Builder do
 provider :twitter, Rails.application.secrets.twitter_consumer_key, Rails.application.secrets.twitter_consumer_secret
 provider :facebook, 1853407901552656, '25c517a3bbcf63785e55e34fc2ff1752',
  scope: 'public_profile', info_fields: 'id,name,link'
end