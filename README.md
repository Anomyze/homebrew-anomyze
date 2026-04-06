# Anomyze Homebrew Tap

Official Homebrew tap for [Anomyze](https://anomyze.com) tools.

## Install

```bash
brew tap Anomyze/anomyze
brew install anomyze
```

## Post-install setup

Register the native messaging host for your Chrome extension:

```bash
anomyzed --install-nmh --extension-id=YOUR_32_CHAR_ID
```

Find your Extension ID at `chrome://extensions` with Developer Mode enabled.
Then fully quit and relaunch Chrome.

## Uninstall

```bash
anomyzed --uninstall-nmh
brew uninstall anomyze
brew untap Anomyze/anomyze
```

## Available formulas

| Formula | Description |
|---------|-------------|
| `anomyze` | P2P daemon — encrypted mesh network for Chrome |

## License

This tap (install recipes) is MIT licensed. The Anomyze daemon binary is proprietary.
See [anomyze.com](https://anomyze.com) for terms.
