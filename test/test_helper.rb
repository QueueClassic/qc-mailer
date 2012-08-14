# test/test_helper.rb

ENV["TEST"] = 'true'
ENV["DATABASE_URL"] ||= "postgres:///queue_classic_test"

$:.unshift File.expand_path("../../lib")
require 'rubygems'
require 'minitest/autorun'
require 'pry'
require 'time'

require 'qc-mailer'
Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each {|f| require f}
