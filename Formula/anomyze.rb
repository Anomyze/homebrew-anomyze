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
  version "0.5.0-m53-peer-connected"
  license "Proprietary"

  on_macos do
    on_arm do
      url "https://download.anomyze.network/releases/daemon/latest/anomyzed-darwin-arm64"
      sha256 "86f7b0805ab55d725fe4b8a76578cdbccba1216251e3b664cd7ba29b328c7d5e"
    end

    on_intel do
      url "https://download.anomyze.network/releases/daemon/latest/anomyzed-darwin-amd64"
      sha256 "166370fad6b37e0ecde2d6d475c6cdd3e6dd6d47f6a76f88ddacb05516736021"
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
