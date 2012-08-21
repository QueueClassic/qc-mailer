require "active_support/concern"
require "qc-mailer/version"
require "qc-mailer/message_decoy"

module QC
  module Mailer
    extend ActiveSupport::Concern

    included do 
      extend(ClassMethods)
    end
      
    # ModuleMethods
    mattr_accessor :default_queue
    def self.default_queue
      @@default_queue || QC::QUEUE || "default"
    end

    # ClassMethods
    module ClassMethods
      def queue_name
        @queue_name || QC::Mailer.default_queue
      end

      def queue_name=(val)
        @queue_name = val
      end

      def queue
        @queue ||= QC::Queue.new(queue_name)
      end

      def deliver(method, *args)
        send(method, *args).deliver!
      end

      def method_missing(method_name, *args)
        if action_methods.include?(method_name.to_s)
          MessageDecoy.new(self, method_name, *args)
        else
          super
        end
      end
    end

  end
end
