module ActiveRecordExtension
  extend ActiveSupport::Concern

  module ClassMethods
    def using
      self
    end
  end
end


#include the extension
ActiveRecord::Base.send(:include, ActiveRecordExtension)