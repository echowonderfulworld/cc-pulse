#!/bin/bash
# cc-token-status uninstaller
set -euo pipefail

echo "cc-token-status uninstaller"
echo ""

# Plugin
PLUGIN_DIR=$(defaults read com.ameba.SwiftBar PluginDirectory 2>/dev/null || echo "$HOME/Library/Application Support/SwiftBar/plugins")
rm -f "$PLUGIN_DIR/cc-token-stats.5m.py"
echo "✓ Plugin removed"

# Config
rm -rf ~/.config/cc-token-stats
echo "✓ Config removed"

# iCloud sync data (optional)
ICLOUD_DIR="$HOME/Library/Mobile Documents/com~apple~CloudDocs/cc-token-stats"
if [ -d "$ICLOUD_DIR" ]; then
    read -p "Remove iCloud sync data? (y/N) " -n 1 -r < /dev/tty 2>/dev/null || REPLY="n"
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        rm -rf "$ICLOUD_DIR"
        echo "✓ iCloud data removed"
    else
        echo "  Kept: $ICLOUD_DIR"
    fi
fi

echo ""
echo "✓ cc-token-status uninstalled"
echo ""
echo "Note: SwiftBar was not removed. To uninstall SwiftBar:"
echo "  brew uninstall --cask swiftbar"
