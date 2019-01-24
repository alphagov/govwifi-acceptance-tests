require 'socket'
require 'sequel'

describe 'GovWifi' do
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

  context 'Authorisation' do
    before do
      db[:userdetails].truncate

      db[:userdetails].insert(
        {
          username: 'DSLPR',
          contact: '+447766554430',
          password: 'SharpRegainDetailed',
          mobile: '+447766554430'
        }
      )
    end
    let(:configuration) { 'peap-mschapv2-accept.conf' }

    it 'ACCEPT' do
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

      it 'logs exactly one sessions' do
        eapol_test_command
        expect(db[:sessions].count).to eq(1)
      end
    end
  end

  context 'Authorisation' do
    let(:configuration) { 'peap-mschapv2-reject.conf' }

    it 'REJECT' do
      expect(result).to eq('FAILURE')
    end

    context 'Radius shared secret' do
      let(:configuration) { 'peap-mschapv2-accept.conf' }
      let(:radius_key) { 'somerandomkey' }

      it 'REJECT' do
        expect(result).to eq('FAILURE')
      end
    end
  end
end
