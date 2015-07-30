class Mailer < ActionMailer::Base
  include Resque::Mailer

  default from: "from@example.com"
  def testing
        mail(to: "martinalonso@berkeley.edu",
        subject: "Testing the emailer", from: "from@example.com")
  end
end