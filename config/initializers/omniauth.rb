Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
  provider :facebook, ENV['1853407901552656'], ENV['25c517a3bbcf63785e55e34fc2ff1752'],
  scope: 'public_profile', info_fields: 'id,name,link'
end