require 'socket'
require 'sequel'
require 'spec_helper.rb'

describe 'GovWifi Certificate Authentication' do
  context 'With valid eap-tls' do
    it_behaves_like 'a valid auth', configuration='eap-tls-accept.conf'
    it 'logs the certificate name' do
      eapol_test_command
      expect(db[:sessions].first[:cert_name]).to eq("Example user")
    end
  end

  context 'with invalid eap-tls' do
    it_behaves_like 'an invalid auth', configuration='eap-tls-reject.conf'
  end
end
