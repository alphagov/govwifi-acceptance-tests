require 'net/http'
require 'sequel'

describe 'GovWifi Healtcheck' do
  let(:db) do
    Sequel.connect(
      adapter: 'mysql2',
      host: ENV.fetch('DB_HOSTNAME'),
      database: ENV.fetch('DB_NAME'),
      user: ENV.fetch('DB_USER'),
      password: ENV.fetch('DB_PASS')
    )
  end

  let(:frontend_container) { ENV.fetch('FRONTEND_CONTAINER') }
  let(:request) { Net::HTTP.new("#{frontend_container}", port=3000) }

  it 'gets a 200 from the healtcheck' do
    response = request.get('/')
    expect(response.code).to eq('200')
  end
end
