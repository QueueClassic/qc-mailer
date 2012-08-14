require_relative "./test_helper"

class Rails3Mailer < ActionMailer::Base
  include QC::Mailer
  default :from => "from@example.org", :subject => "Subject"
  MAIL_PARAMS = { :to => "testme@example.org" }

  def test_mail(*params)
    # QC::Mailer.success!
    mail(*params)
  end
end

class PriorityMailer < Rails3Mailer
  self.queue = 'priority_mailer'
end


describe 'QC::Mailer' do

  describe "default_queue" do
    it "should be 'default'" do
      QC::Mailer.default_queue.must_equal("default")
    end
  end

  describe "queue" do
    before do
      QC::Mailer.default_queue = nil
      Rails3Mailer.queue = nil
    end

    it "allows overriding of the default queue target (for testing)" do
      QC::Mailer.default_queue = "mailer"
      Rails3Mailer.queue.must_equal("mailer")
    end

    it "set queue manually" do
      Rails3Mailer.queue = "testing"
      Rails3Mailer.queue.must_equal("testing")
    end

    it "set at class level" do
      QC::Mailer.default_queue.must_equal("default")
      Rails3Mailer.queue.must_equal("default")
      PriorityMailer.queue.must_equal('priority_mailer')
    end
  end

end