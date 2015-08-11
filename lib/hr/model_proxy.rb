module HR
  class ModelProxy < BasicObject

    def initialize(db, wrapped_klass)
      @db = db
      @wrapped_klass= klass
    end

    def transaction (option ={}, &block)

    end

    def connection

    end

  end
end