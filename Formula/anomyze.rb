# Homebrew formula for the Anomyze daemon.
#
# Tap:     brew tap Anomyze/anomyze
# Install: brew install anomyze
#
# After install, register the NMH manifest for your Chrome extension:
#   anomyze --install-nmh --extension-id=YOUR_32_CHAR_ID
# Then fully quit and relaunch Chrome.
#
# THIS FILE IS THE TEMPLATE for scripts/ops/release-homebrew.sh. At release
# time the script sets `version`, points every `url` at the immutable
# releases/daemon/vX.Y.Z/ directory, fills each `sha256` from that release's
# SHA256SUMS, writes the result back here and stages it in the tap for the
# owner to push. Edit everything else (desc, install, caveats) by hand.
# Until a versioned release has been rendered, the sha256 values below are
# placeholders: brew refuses to install on the checksum mismatch.
#
# Binary renamed from `anomyzed` → `anomyze` in 0.6.1. A backwards-compat
# `anomyzed` symlink is installed alongside the new binary for one release
# line so existing scripts that call `anomyzed` keep working.

class Anomyze < Formula
  desc "Anomyze P2P daemon — encrypted mesh network for Chrome"
  homepage "https://anomyze.com"
  version "0.9.2"
  license "Proprietary"

  on_macos do
    on_arm do
      url "https://download.anomyze.network/releases/daemon/v0.9.2/anomyze-darwin-arm64"
      sha256 "57785baf01b44de47bf94ecdff79e4a5e21f6dcfdede777c896cd4d8904fed89"
    end

    on_intel do
      url "https://download.anomyze.network/releases/daemon/v0.9.2/anomyze-darwin-amd64"
      sha256 "9eeff92f1c7b8e6228ca8787f36cdf349bcbeb0430d71285511cac5f64e069ce"
    end
  end

  on_linux do
    on_arm do
      url "https://download.anomyze.network/releases/daemon/v0.9.2/anomyze-linux-arm64"
      sha256 "e7a0e8684caf2b524b7f22e9afd36e2d6b42abc29ce02836d5391ebddd86f16c"
    end

    on_intel do
      url "https://download.anomyze.network/releases/daemon/v0.9.2/anomyze-linux-amd64"
      sha256 "41b6789da4b7cc18a3867c22e460a76bf4d1752cecde20d230aa560c6f67f849"
    end
  end

  def install
    # The downloaded file has the full architecture-specific name.
    # Rename it to `anomyze` on install.
    bin.install Dir["anomyze-*"].first => "anomyze"
    # Backwards-compat symlink — one release line.
    bin.install_symlink "anomyze" => "anomyzed"
  end

  def caveats
    <<~EOS
      To complete setup, register the NMH manifest for your Chrome extension:

        anomyze --install-nmh --extension-id=YOUR_32_CHAR_ID

      Your Extension ID is visible at chrome://extensions with Developer Mode on.
      Then FULLY QUIT Chrome (⌘Q on Mac) and relaunch.

      To use the daemon path from the webapp (anomyze.network), trust the
      daemon's local CA — wss://localhost only works once it's in your keychain:

        anomyze --install-trust

      Run it as yourself, not with sudo. It creates ~/.anomyze/certs/wss-ca.pem
      if missing (a CA limited to localhost, 127.0.0.0/8 and ::1 whose signing
      key is never stored) and adds it to your login keychain. Upgrading from
      an older release: run it again — it replaces the old, unrestricted CA.

      The legacy `anomyzed` command is a symlink to `anomyze` for this release.
      New scripts should call `anomyze` directly.

      To uninstall the NMH manifest + CA trust before removing this formula:
        anomyze --uninstall-nmh
        anomyze --uninstall-trust
    EOS
  end

  test do
    assert_match "anomyze", shell_output("#{bin}/anomyze --version")
  end
end
