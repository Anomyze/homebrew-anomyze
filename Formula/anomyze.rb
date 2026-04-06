# Homebrew formula for the Anomyze daemon.
#
# Tap:     brew tap Anomyze/anomyze
# Install: brew install anomyze
#
# After install, register the NMH manifest for your Chrome extension:
#   anomyzed --install-nmh --extension-id=YOUR_32_CHAR_ID
# Then fully quit and relaunch Chrome.
#
# Update checksums and version by running:
#   make homebrew-formula   (from anomyze-daemon/)

class Anomyze < Formula
  desc "Anomyze P2P daemon — encrypted mesh network for Chrome"
  homepage "https://anomyze.com"
  version "0.4.0"
  license "Proprietary"

  on_macos do
    on_arm do
      url "https://static.anomyze.network/releases/daemon/latest/anomyzed-darwin-arm64"
      sha256 "bf2a3e309833f8eb926e2f5239354f6c7dab50a1b083ba93ae93152cc4084680"
    end

    on_intel do
      url "https://static.anomyze.network/releases/daemon/latest/anomyzed-darwin-amd64"
      sha256 "c0bad33ecdc37146de191ccd2cf0b6203b8f24b5d1b99d36ebc9c7121cf3727a"
    end
  end

  on_linux do
    on_arm do
      url "https://static.anomyze.network/releases/daemon/latest/anomyzed-linux-arm64"
      sha256 "add27a99d2f4be88584d83795ec73c7a947bfb19e09fda0da958bc728aaf9606"
    end

    on_intel do
      url "https://static.anomyze.network/releases/daemon/latest/anomyzed-linux-amd64"
      sha256 "707acde5d3c3a0c70db8fa8225fe06053c32cf2a0a192da005043bab90f4fcdd"
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
      Then fully quit and relaunch Chrome.

      To uninstall the NMH manifest before removing this formula:
        anomyzed --uninstall-nmh
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/anomyzed --version")
  end
end
