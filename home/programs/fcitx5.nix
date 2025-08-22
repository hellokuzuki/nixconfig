{ config, pkgs, ... }:

{
  # Enable fcitx5 input method in home-manager
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-chinese-addons
      fcitx5-gtk
      libsForQt5.fcitx5-qt
      catppuccin-fcitx5
    ];
  };

  # Set environment variables for fcitx5
  # Note: GTK_IM_MODULE is commented out for Wayland compatibility
  # Wayland uses its native input method protocol instead
  home.sessionVariables = {
    # GTK_IM_MODULE = "fcitx"; # Disabled for Wayland - use native protocol
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
    INPUT_METHOD = "fcitx";
    SDL_IM_MODULE = "fcitx";
    GLFW_IM_MODULE = "ibus"; # Some apps work better with ibus setting
  };

  # Configure fcitx5 with Catppuccin theme
  xdg.configFile."fcitx5/conf/classicui.conf".text = ''
    # Vertical Candidate List
    Vertical Candidate List=False
    # Use Per Screen DPI
    PerScreenDPI=True
    # Use mouse wheel to go to prev or next page
    WheelForPaging=True
    # Font
    Font="Xiaolai Mono SC 10"
    # Menu Font
    MenuFont="Xiaolai Mono SC 10"
    # Tray Font
    TrayFont="Xiaolai Mono SC Bold 10"
    # Tray Label Outline Color
    TrayOutlineColor=#000000
    # Tray Label Text Color
    TrayTextColor=#ffffff
    # Prefer Text Icon
    PreferTextIcon=False
    # Show Layout Name In Icon
    ShowLayoutNameInIcon=True
    # Use input method language to display text
    UseInputMethodLangaugeToDisplayText=True
    # Theme
    Theme=catppuccin-mocha
    # Dark Theme
    DarkTheme=catppuccin-macchiato
    # Follow system light/dark color scheme
    UseDarkTheme=True
    # Follow system accent color if available
    UseAccentColor=False
    # Enable fractional scale
    EnableFractionalScale=True
  '';
}