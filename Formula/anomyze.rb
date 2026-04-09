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
  version "v0.1.0-libp2p-316-g1cead99f-dirty"
  license "Proprietary"

  on_macos do
    on_arm do
      url "https://download.anomyze.network/releases/daemon/latest/anomyzed-darwin-arm64"
      sha256 "fe8bf2002e607caed3bbd8a3efe1147e1c8075a98f7ebae52ba7d8745ec3e195"
    end

    on_intel do
      url "https://download.anomyze.network/releases/daemon/latest/anomyzed-darwin-amd64"
      sha256 "b87733e014c7f8ee21415d9e1ce6a56f9610c4baeecee6ddcc9e85168ac15f7b"
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
