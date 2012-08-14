require_relative "./test_helper"

class Rails3Mailer < ActionMailer::Base
  include QC::Mailer
  default :from => "from@example.org", :subject => "Subject"

  def test_mail(*params)
    mail(*params)
  end
end

class PriorityMailer < Rails3Mailer
  self.queue_name = 'priority-mailer'
end


describe 'QC::Mailer' do
  include QCHelper
  
  before do
    ActionMailer::Base.deliveries = []
    @test_mail = Rails3Mailer.test_mail( 'to' => "testme@example.org" )
  end

  describe "default_queue" do
    it "should be 'mailer'" do
      QC::Mailer.default_queue.must_equal("mailer")
    end
  end

  describe "queue_name" do
    before do
      QC::Mailer.default_queue = nil
      Rails3Mailer.queue_name = nil
    end

    it "allows overriding of the default queue target" do
      QC::Mailer.default_queue = "my-queue"
      Rails3Mailer.queue_name.must_equal("my-queue")
    end

    it "set queue_name manually" do
      Rails3Mailer.queue_name = "testing"
      Rails3Mailer.queue_name.must_equal("testing")
    end

    it "set at class level" do
      QC::Mailer.default_queue.must_equal("mailer")
      Rails3Mailer.queue_name.must_equal("mailer")
      PriorityMailer.queue_name.must_equal('priority-mailer')
    end
  end

  describe "queue" do
    it "should be a QC::Queue" do
      Rails3Mailer.queue.must_be_instance_of(QC::Queue)
    end
  end

  describe '#deliver' do
    it 'should not deliver the email synchronously' do
      @test_mail.deliver
      ActionMailer::Base.deliveries.must_be_empty
    end

    it 'should place the deliver action on the QC "mailer" queue' do
      Rails3Mailer.queue.count.must_equal(0)
      @test_mail.deliver
      Rails3Mailer.queue.count.must_equal(1)
    end
  end

  describe "#deliver job" do
    it "should process the job" do
      Rails3Mailer.queue.stub(:enqueue, enqueue_stub) do
        ActionMailer::Base.deliveries.must_be_empty
        @test_mail.deliver
        ActionMailer::Base.deliveries.wont_be_empty
      end
    end
  end

  describe '#deliver!' do
    it "should send synchronously" do
      @test_mail.deliver!
      ActionMailer::Base.deliveries.wont_be_empty
    end
  end

  describe 'original mail methods' do
    it 'should be preserved' do
      @test_mail.subject.must_equal 'Subject'
      @test_mail.from.must_include 'from@example.org'
      @test_mail.to.must_include 'testme@example.org'
    end

    it "to_s should have Content-Type" do
      @test_mail.to_s.must_include "Content-Type:"
    end
  end
end