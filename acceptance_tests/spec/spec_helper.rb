require 'socket'
require 'sequel'

Dir["./spec/support/shared_examples/*.rb"].sort.each { |f| require f }


module DBHelper
  extend RSpec::SharedContext
  let(:sessions_db) do
    Sequel.connect(
      adapter: 'mysql2',
      host: ENV.fetch('DB_HOSTNAME'),
      database: ENV.fetch('DB_NAME'),
      user: ENV.fetch('DB_USER'),
      password: ENV.fetch('DB_PASS')
    )
  end

  let(:user_details_db) do
    Sequel.connect(
      adapter: 'mysql2',
      host: ENV.fetch('USER_DB_HOSTNAME'),
      database: ENV.fetch('USER_DB_NAME'),
      user: ENV.fetch('USER_DB_USER'),
      password: ENV.fetch('USER_DB_PASS')
    )
  end

  before do
    sessions_db[:sessions].truncate
    user_details_db[:userdetails].truncate
  end
end

module EnvHelper
  extend RSpec::SharedContext
  let(:frontend_container) { ENV.fetch('FRONTEND_CONTAINER') }
  let(:frontend_container_ip) do
    Addrinfo.getaddrinfo(frontend_container, nil).first.ip_address
  end

  let(:radius_key) { ENV.fetch('RADIUS_KEY') }
end

RSpec.configure do |c|
  c.include DBHelper
  c.include EnvHelper
end
