module ActiveRecordExtension
  extend ActiveSupport::Concern

  module ClassMethods
    def using db_name
      HR::SwitchDatabase.get_connection_proxy db_name, self
    end

    def connection
      HR::SwitchDatabase.get_current_connection || super
    end

  end
end


#include the extension
ActiveRecord::Base.send(:include, ActiveRecordExtension)