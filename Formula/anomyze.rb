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
  version "0.10.0"
  license "Proprietary"

  on_macos do
    on_arm do
      url "https://download.anomyze.network/releases/daemon/v0.10.0/anomyze-darwin-arm64"
      sha256 "59a46c0331b44272f55166c91716c4a2a99089a53564fd1ba0400490f9e1bbc2"
    end

    on_intel do
      url "https://download.anomyze.network/releases/daemon/v0.10.0/anomyze-darwin-amd64"
      sha256 "bbf2f28c3b361cd6968d3742e3cf72b4b6d912dcedee536bdd28e8947dfc4ddd"
    end
  end

  on_linux do
    on_arm do
      url "https://download.anomyze.network/releases/daemon/v0.10.0/anomyze-linux-arm64"
      sha256 "2b8a634758ab1ca164aa1837bc7596423f08f031c770a0d391de49c0674656a5"
    end

    on_intel do
      url "https://download.anomyze.network/releases/daemon/v0.10.0/anomyze-linux-amd64"
      sha256 "a98caa0dbbdff8aaef512691f31746b10570ac852a72294a7ed97b3224828dc8"
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
