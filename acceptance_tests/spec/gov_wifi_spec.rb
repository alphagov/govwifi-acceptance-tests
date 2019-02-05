require 'spec_helper.rb'

describe 'GovWifi' do
  context 'with valid peap-mschapv2' do
    let(:configuration) { 'peap-mschapv2-accept.conf' }
    it_behaves_like 'a valid auth'
  end

  context 'with invalid peap-mschapv2' do
    let(:configuration) { 'peap-mschapv2-reject.conf' }
    it_behaves_like 'an invalid auth'
  end
end
