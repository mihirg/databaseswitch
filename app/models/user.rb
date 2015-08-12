
class User < ActiveRecord::Base

=begin
  def self.connection
    HR::SwitchDatabase.get_current_connection || super
  end
=end

  def self.do_work

#    databases = YAML::load_file("config/database.yml")
#    configurations = ActiveRecord::ConnectionHandling::MergeAndResolveDefaultUrlConfig.new(databases).resolve
#    resolver =   ActiveRecord::ConnectionAdapters::ConnectionSpecification::Resolver.new configurations
#    spec     =   resolver.spec(:replica)
#    connection_pool = ActiveRecord::ConnectionAdapters::ConnectionPool.new(spec)

    x = User.where(id: 55).using(:replica)[0]

    HR::SwitchDatabase.use :replica do
      u = User.new({name: "Mihir", location:"replica"})
      u.save
    end

    u = User.new({name: "Gore", location:"master"})
    u.save

    HR::SwitchDatabase.use :replica

    u = User.new({name: "Mihir1", location:"replica"})
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