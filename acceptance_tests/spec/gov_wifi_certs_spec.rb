require 'socket'
require 'sequel'
require 'spec_helper.rb'

describe 'GovWifi Certificate Authentication' do
  context 'With valid eap-tls' do
    it_behaves_like(
      'a valid auth',
      configuration='eap-tls-accept.conf',
      logged_with={cert_name: "Example user"}
    )
  end

  context 'with invalid eap-tls' do
    it_behaves_like 'an invalid auth', configuration='eap-tls-reject.conf'
  end
end
