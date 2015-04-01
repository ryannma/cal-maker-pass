OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '321338533517-98fu8aq433cbiaqcjga527mot4ehmml1.apps.googleusercontent.com', '_iMMZ9yfwzTguUx1iDenEYBa' #{client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end