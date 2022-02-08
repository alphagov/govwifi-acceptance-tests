require 'spec_helper.rb'

describe 'GovWifi' do
  context 'with valid peap-mschapv2' do
    it_behaves_like 'a valid auth', configuration='peap-mschapv2-accept.conf'
    it_behaves_like 'using TLS version 1.2', configuration='peap-mschapv2-accept.conf'
  end

  context 'with invalid peap-mschapv2' do
    it_behaves_like 'an invalid auth', configuration='peap-mschapv2-reject.conf'
    it_behaves_like 'using TLS version 1.2', configuration='peap-mschapv2-reject.conf'
  end

  context 'with valid peap-mschapv2 and TLS1.0' do
    it_behaves_like 'a valid auth', configuration='peap-mschapv2-accept-tls1.0.conf'
    it_behaves_like 'using TLS version 1.0', configuration='peap-mschapv2-accept-tls1.0.conf'
  end
end
