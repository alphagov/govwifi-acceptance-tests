require 'socket'
require 'sequel'

describe 'GovWifi Certificate Authentication' do
  let(:db) do
    Sequel.connect(
      adapter: 'mysql2',
      host: ENV.fetch('DB_HOSTNAME'),
      database: ENV.fetch('DB_NAME'),
      user: ENV.fetch('DB_USER'),
      password: ENV.fetch('DB_PASS')
    )
  end

  let(:frontend_container_ip) do
    TCPSocket.gethostbyname(ENV.fetch('FRONTEND_CONTAINER')).last
  end

  let(:radius_key) { ENV.fetch('RADIUS_KEY') }

  let(:eapol_test_command) do
    `eapol_test -t5 -c ./spec/support/#{configuration} -a #{frontend_container_ip} -s #{radius_key}`
  end

  let(:result) { eapol_test_command.split("\n").last }

  context 'With valid credentials' do
    let(:configuration) { 'eap-tls-accept.conf' }

    it 'Authenticates successfully' do
      expect(result).to match('SUCCESS')
    end

    context 'Logging' do
      before do
        db[:sessions].truncate
      end

      it 'logs the authentication' do
        eapol_test_command
        expect(db[:sessions].order(:id).last).to_not be_nil
      end

      it 'logs one session' do
        eapol_test_command
        expect(db[:sessions].count).to eq(1)
      end

      it 'logs the certificate name' do
        eapol_test_command
        expect(db[:sessions].first[:cert_name]).to eq("Example user")
      end
    end

    context 'With an invalid shared secret' do
      let(:radius_key) { 'somerandomkey' }

      it 'Rejects the authentication request' do
        expect(result).to eq('FAILURE')
      end
    end
  end

  context 'With invalid credentials' do
    let(:configuration) { 'eap-tls-reject.conf' }

    it 'Authenticates successfully' do
      expect(result).to eq('FAILURE')
    end
  end
end
