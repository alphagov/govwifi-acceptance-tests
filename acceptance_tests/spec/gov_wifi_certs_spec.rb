require 'socket'
require 'sequel'
require 'spec_helper.rb'

describe 'GovWifi Certificate Authentication' do
  context 'With valid eap-tls' do
    let(:configuration) { 'eap-tls-accept.conf' }
    it_behaves_like 'a valid auth'
    it 'logs the certificate name' do
      eapol_test_command
      expect(db[:sessions].first[:cert_name]).to eq("Example user")
    end
  end

  context 'with invalid eap-tls' do
    let(:configuration) { 'eap-tls-reject.conf' }
    it_behaves_like 'an invalid auth'
  end
end
