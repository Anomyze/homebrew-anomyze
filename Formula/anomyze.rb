# Homebrew formula for the Anomyze daemon.
# Tap:     brew tap Anomyze/anomyze
# Install: brew install anomyze
#
# After install, register the NMH manifest for your Chrome extension:
#   anomyzed --install-nmh --extension-id=YOUR_32_CHAR_ID
# Then fully quit and relaunch Chrome.

class Anomyze < Formula
  desc "Anomyze P2P daemon — encrypted mesh network for Chrome"
  homepage "https://anomyze.com"
  version "v0.1.0-libp2p-323-ge4eb426e-dirty"
  license "Proprietary"

  on_macos do
    on_arm do
      url "https://download.anomyze.network/releases/daemon/latest/anomyzed-darwin-arm64"
      sha256 "33c33423c46982ada2780838391ae4730035b89d1682ca09f1bd6e7eab01a1a0"
    end

    on_intel do
      url "https://download.anomyze.network/releases/daemon/latest/anomyzed-darwin-amd64"
      sha256 "08a883a4157b53add765bc3c995ae9474b0591b69445c1c07464628b1ef6bcf0"
    end
  end

  def install
    bin.install Dir["anomyzed*"].first => "anomyzed"
  end

  def caveats
    <<~EOS
      To complete setup, register the NMH manifest for your Chrome extension:

        anomyzed --install-nmh --extension-id=YOUR_32_CHAR_ID

      Your Extension ID is visible at chrome://extensions with Developer Mode on.
      Then fully quit and relaunch Chrome (⌘Q).

      To uninstall the NMH manifest before uninstalling this formula:
        anomyzed --uninstall-nmh
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/anomyzed --version")
  end
end
