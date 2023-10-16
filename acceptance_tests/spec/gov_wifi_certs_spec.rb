require "spec_helper"

describe "GovWifi Certificate Authentication" do
  context "With valid eap-tls" do
    it_behaves_like(
      "a valid auth",
      "eap-tls-accept.conf",
      { cert_name: "Example user" },
    )

    it_behaves_like "using TLS version 1.2", "eap-tls-accept.conf"
  end

  context "With valid eap-tls and TLS 1.0" do
    it_behaves_like(
      "a valid auth",
      "eap-tls-accept-tls1.0.conf",
      { cert_name: "Example user" },
    )

    it_behaves_like "using TLS version 1.0", "eap-tls-accept-tls1.0.conf"
  end

  context "with invalid eap-tls" do
    it_behaves_like "an invalid auth", "eap-tls-reject.conf"
    it_behaves_like "using TLS version 1.2", "eap-tls-reject.conf"
  end
end
