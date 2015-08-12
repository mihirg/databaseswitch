module HR
  class ScopeProxy < BasicObject

    def initialize replica_name, klass
      @replica_name = replica_name
      @klass = klass
    end

    def using replica_name
      @replica_name = replica_name
      self
    end

    def connection
      @klass.connection_proxy.current_model = @klass
      @klass.connection_proxy.current_replica = @replica_name
      @klass.connection_proxy
    end

    def method_missing(method, *args, &block)
    end

  end
end