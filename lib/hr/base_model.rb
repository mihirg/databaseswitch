module HR
=begin
  puts "Loading HR"
  module BaseModel
    def self.extended(base)
      base.extend(ClassInstanceMethods)
    end

    module ClassInstanceMethods
      def using
        self
      end
    end
  end
=end
end

#ActiveRecord::Base.extend(HR::BaseModel)