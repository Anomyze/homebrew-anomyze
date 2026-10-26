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
  version "0.11.0"
  license "Proprietary"

  on_macos do
    on_arm do
      url "https://download.anomyze.network/releases/daemon/v0.11.0/anomyze-darwin-arm64"
      sha256 "12b8fe6ca643a32b0ccca8f85bcf1d20b31328fbbf314e57d8b338897cc5ea21"
    end

    on_intel do
      url "https://download.anomyze.network/releases/daemon/v0.11.0/anomyze-darwin-amd64"
      sha256 "11516da24548ffe819bb6a8def95e3b8bd162776be2aa57c562e826357af8f28"
    end
  end

  on_linux do
    on_arm do
      url "https://download.anomyze.network/releases/daemon/v0.11.0/anomyze-linux-arm64"
      sha256 "a7e9123c1510b7c242ec80da4de028be87284fe72311f85ec236bdeb8e6a1d4f"
    end

    on_intel do
      url "https://download.anomyze.network/releases/daemon/v0.11.0/anomyze-linux-amd64"
      sha256 "6f8786618c0952da3a37531d72ce23b6c10c37573226c15035faf0cc9528167c"
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
