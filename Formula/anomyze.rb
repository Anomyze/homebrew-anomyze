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
  version "v0.1.0-libp2p-322-g1a6dc6c7-dirty"
  license "Proprietary"

  on_macos do
    on_arm do
      url "https://download.anomyze.network/releases/daemon/latest/anomyzed-darwin-arm64"
      sha256 "069f20432438cbd581a8ea472b404de9f3877cece70f5310acb5c0368fbefb9f"
    end

    on_intel do
      url "https://download.anomyze.network/releases/daemon/latest/anomyzed-darwin-amd64"
      sha256 "abd84e7fe79294b2fd23b27d696c0e90188958ed78241a28c1be2c2bbf30c6d4"
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
