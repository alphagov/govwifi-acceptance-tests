require 'spec_helper.rb'

describe 'GovWifi Certificate Authentication' do
  context 'With valid eap-tls' do
    it_behaves_like(
      'a valid auth',
      configuration='eap-tls-accept.conf',
      logged_with={cert_name: "Example user"}
    )

    it_behaves_like 'using TLS version 1.2', configuration='eap-tls-accept.conf'
  end

  context 'With valid eap-tls and TLS 1.0' do
    it_behaves_like(
      'a valid auth',
      configuration='eap-tls-accept-tls1.0.conf',
      logged_with={cert_name: "Example user"}
    )

    it_behaves_like 'using TLS version 1.0', configuration='eap-tls-accept-tls1.0.conf'
  end

  context 'with invalid eap-tls' do
    it_behaves_like 'an invalid auth', configuration='eap-tls-reject.conf'
    it_behaves_like 'using TLS version 1.2', configuration='eap-tls-reject.conf'
  end
end
