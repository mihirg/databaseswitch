
class User < ActiveRecord::Base

  def self.connection
    HR::Scd witchDatabase.get_current_connection || super
  end

  def self.do_work

#    databases = YAML::load_file("config/database.yml")
#    configurations = ActiveRecord::ConnectionHandling::MergeAndResolveDefaultUrlConfig.new(databases).resolve
#    resolver =   ActiveRecord::ConnectionAdapters::ConnectionSpecification::Resolver.new configurations
#    spec     =   resolver.spec(:replica)
#    connection_pool = ActiveRecord::ConnectionAdapters::ConnectionPool.new(spec)

    HR::SwitchDatabase.use :replica do
      u = User.new({name: "Mihir", location:"replica"})
      u.save
    end

    u = User.new({name: "Gore", location:"master"})
    u.save


=begin
    cp_test = HR::ConnectionManager.new
    Rails.configuration.cp.with_connection(:db1) do |conn|
      obj = User.new({name: "Test", location:"replica"})
      obj.save
    end
=end
  end
end