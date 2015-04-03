# Load the rails application
require File.expand_path('../application', __FILE__)
require 'casclient'
require 'casclient/frameworks/rails/filter'

# Initialize the rails application
Makerpass::Application.initialize!

CASClient::Frameworks::Rails::Filter.configure(
  :cas_base_url => "https://auth.berkeley.edu/cas/" 
)
