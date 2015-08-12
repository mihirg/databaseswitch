module HR

  # This class proxies a connection pool. The connectin pool is passed to it.
  class Proxy

    def initialize

    end

    def current_model
      Thread.current[:hr_current_model]
    end

    def current_model= klass
      Thread.current[:hr_current_model] = klass
    end

    def current_replica
      Thread.current[:hr_current_replica]
    end

    def current_replica= replica
      Thread.current[:hr_current_replica] = replica
    end
  end
end