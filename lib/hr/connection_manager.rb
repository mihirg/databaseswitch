module HR

  class ConnectionPoolWrapper
    def initialize cp
      @connection_pool = cp
    end

    def connection &block
      if block_given?
        @connection_pool.with_connection(&block)
      else
        @connection_pool.connection
      end
    end
  end

  class ConnectionManager

    def initialize
      databases = YAML::load_file("config/database.yml")
      configurations = ActiveRecord::ConnectionHandling::MergeAndResolveDefaultUrlConfig.new(databases).resolve
      resolver =   ActiveRecord::ConnectionAdapters::ConnectionSpecification::Resolver.new configurations
      spec     =   resolver.spec(:replica)
      @connection_pool = ActiveRecord::ConnectionAdapters::ConnectionPool.new(spec)
      @connection_pool_wrapper = ConnectionPoolWrapper.new @connection_pool
    end

    def get db_name, &block
      if block_given?
        yield @connection_pool_wrapper
      else
        @connection_pool_wrapper
      end
    end

    def use db_name, &block
      result = nil
      get db_name do |conn_pool_wrapper|
        if block_given?
          conn_pool_wrapper.connection do |connection|
            Thread.current[:hr_connection] = connection
            begin
              result = yield
            ensure
              Thread.current[:hr_connection] = nil
            end
            result
          end
        else
          result = Thread.current[:hr_connection] = conn_pool_wrapper.connection
        end
      end
      result
    end

    def current_connection
      Thread.current[:hr_connection]
    end

  end
end