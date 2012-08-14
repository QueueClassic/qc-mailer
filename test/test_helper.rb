# test/test_helper.rb

ENV["TEST"] = 'true'
ENV["DATABASE_URL"] ||= "postgres:///queue_classic_test"

$:.unshift File.expand_path("../../lib")
require 'rubygems'
require 'minitest/autorun'
require "minitest/reporters"
require 'pry'
require 'time'
require 'action_mailer'
require 'qc-mailer'

MiniTest::Reporters.use! [MiniTest::Reporters::SpecReporter.new]
ActionMailer::Base.delivery_method = :test
Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each {|f| require f}
