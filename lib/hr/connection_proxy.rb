module HR
  class ConnectionProxy

    def initialize cp, klass
      @connection_pool = cp
      @klass = klass
    end

=begin
    def transaction(options = {}, &block)
      Rails.logger.info "Transaction Called"
    end
=end

    def method_missing method, *args, &block
      Rails.logger.info method
      conn = @connection_pool.connection
      Thread.current[:hr_connection] = conn
      result = @klass.send(method, *args, &block)
      Thread.current[:hr_connection] = nil
      result
    end
  end
end