{ inputs, pkgs, ... }:
{
  # Configure fcitx5 profile with Pinyin input method
  xdg.configFile."fcitx5/profile".text = ''
    [Groups/0]
    # Group Name
    Name=Default
    # Layout
    Default Layout=us
    # Default Input Method
    DefaultIM=keyboard-us

    [Groups/0/Items/0]
    # Name
    Name=keyboard-us
    # Layout
    Layout=

    [Groups/0/Items/1]
    # Name
    Name=pinyin
    # Layout
    Layout=

    [GroupOrder]
    0=Default
  '';

  # Configure fcitx5 to use the Catppuccin mocha theme
  xdg.configFile."fcitx5/conf/classicui.conf".text = ''
    # Vertical Candidate List
    Vertical Candidate List=False
    # Use Per Screen DPI
    PerScreenDPI=True
    # Use mouse wheel to go to prev or next page
    WheelForPaging=True
    # Font
    Font="Xiaolai Mono SC 13"
    # Menu Font
    MenuFont="Xiaolai Mono SC 13"
    # Tray Font
    TrayFont="Xiaolai Mono SC Bold 13"
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
    Theme=catppuccin-latte-mauve
    # Dark Theme
    DarkTheme=catppuccin-mocha-pink
    # Follow system light/dark color scheme
    UseDarkTheme=True
    # Follow system accent color if available
    UseAccentColor=False
    # Enable fractional scale
    EnableFractionalScale=True
  '';
}