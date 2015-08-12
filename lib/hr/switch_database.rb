module HR
  class SwitchDatabase

    @balancer = HR::ConnectionManager.new

    def self.use db_name, &block
      @balancer.use db_name, &block
    end

    def self.get_current_connection
      @balancer.current_connection
    end

    def self.get_connection_proxy db_name, klass
      @balancer.get_connection_proxy db_name, klass
    end

  end
end