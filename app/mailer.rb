class Mailer < ActionMailer::Base
  include Resque::Mailer
end