module ActiveRecordExtension
  extend ActiveSupport::Concern

  module ClassMethods
    def using db_name
      HR::ScopeProxy.new db_name, self
    end

    def connection
      HR::SwitchDatabase.get_current_connection || super
    end


    def connection_proxy
      ActiveRecord::Base.class_variable_defined?(:@@connection_proxy) &&
          ActiveRecord::Base.class_variable_get(:@@connection_proxy) ||
          ActiveRecord::Base.class_variable_set(:@@connection_proxy, HR::Proxy.new)
    end

  end
end


#include the extension
ActiveRecord::Base.send(:include, ActiveRecordExtension)