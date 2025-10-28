{ config, pkgs, ... }:

{
  # Install VS Code itself
  home.packages = with pkgs; [
    vscode
  ];

  # Configure VS Code through Home Manager
  programs.vscode = {
    enable = true;
    mutableExtensionsDir = true;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        # Themes
        catppuccin.catppuccin-vsc

        # Language Support
        # vscodevim.vim
        yzhang.markdown-all-in-one
        bbenoist.nix  # Nix language support

      ];
      userSettings = {
        "workbench.colorTheme" = "Catppuccin Mocha";
        "editor.fontFamily" = "'Maple Mono NF', Consolas, 'Courier New', monospace";
        "editor.fontSize" = 16;
        "terminal.integrated.fontSize" = 16;
        "window.zoomLevel" = 1;
        "claude.executablePath" = "/home/mark/.local/bin/claude-code";
      };
    };
  };

  # Fix Claude Code extension to use Nix binary instead of bundled one
  home.activation.fixClaudeCodeExtension = config.lib.dag.entryAfter ["writeBoundary"] ''
    CLAUDE_EXTENSIONS=$(find ~/.vscode/extensions -maxdepth 1 -name "anthropic.claude-code-*" -type d 2>/dev/null || true)

    if [ -n "$CLAUDE_EXTENSIONS" ]; then
      for EXT_DIR in $CLAUDE_EXTENSIONS; do
        BINARY_PATH="$EXT_DIR/resources/native-binary/claude"

        # Only fix if the binary exists and is not already a symlink to our Nix version
        if [ -e "$BINARY_PATH" ] && [ ! -L "$BINARY_PATH" ]; then
          echo "Fixing Claude Code extension binary in $EXT_DIR"
          mv "$BINARY_PATH" "$BINARY_PATH.bak" 2>/dev/null || true
          ln -sf /run/current-system/sw/bin/claude "$BINARY_PATH"
        elif [ -L "$BINARY_PATH" ] && [ "$(readlink "$BINARY_PATH")" != "/run/current-system/sw/bin/claude" ]; then
          echo "Updating Claude Code extension symlink in $EXT_DIR"
          ln -sf /run/current-system/sw/bin/claude "$BINARY_PATH"
        fi
      done
    fi
  '';
}

