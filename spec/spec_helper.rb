ENV['RAILS_ENV'] = 'test'

require 'database_cleaner'

require 'simplecov'
SimpleCov.start do
  # add_group 'Lib', 'lib'
  add_filter 'spec'
end

require 'deleted_at'
DeletedAt.load

db_config = {
  adapter: 'postgresql', database: 'deleted_at_test'
}

db_config_admin = db_config.merge({ database: 'postgres', schema_search_path: 'public' })

ActiveRecord::Base.establish_connection db_config_admin
ActiveRecord::Base.connection.drop_database(db_config[:database])
ActiveRecord::Base.connection.create_database(db_config[:database])
ActiveRecord::Base.establish_connection db_config

load File.dirname(__FILE__) + '/schema.rb'

Dir[File.join(File.dirname(__FILE__), '..', 'spec', 'support', '**', '**.rb')].each do |f|
  require f
end

RSpec.configure do |config|
  config.order = 'random'
end
