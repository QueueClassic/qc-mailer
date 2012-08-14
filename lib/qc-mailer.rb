require "qc-mailer/version"
require "active_support/concern"

module QC
  module Mailer
    extend ActiveSupport::Concern

    included do 
      extend(ClassMethods)
    end
      
    # ModuleMethods
    mattr_accessor :default_queue
    def self.default_queue
      @@default_queue||"default"
    end

    module ClassMethods
      def queue
        @queue || QC::Mailer.default_queue
      end

      def queue=(val)
        @queue = val
      end
    end

  end
end
