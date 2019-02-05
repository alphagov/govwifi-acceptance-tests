require 'spec_helper.rb'

describe 'GovWifi' do
  context 'with valid peap-mschapv2' do
    it_behaves_like 'a valid auth', configuration='peap-mschapv2-accept.conf'
  end

  context 'with invalid peap-mschapv2' do
    it_behaves_like 'an invalid auth', configuration='peap-mschapv2-reject.conf'
  end
end
