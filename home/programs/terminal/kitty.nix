{
  pkgs,
  ...
}:
{
  programs.kitty = {
    enable = true;
    shellIntegration.enableFishIntegration = true;
    settings = {
      window_padding_width = "10 20 10 20";
      cursor_trail = 1;
      cursor_trail_start_threshold = 0;
      bold_font = "family='Maple Mono' style=ExtraBold variable_name=MapleMono";
      background_opacity = "1.0";
      dynamic_background_opacity = "no";
    };
    extraConfig = ''
      # Catppuccin Macchiato Theme
      # The basic colors
      foreground              #CAD3F5
      background              #24273A
      selection_foreground    #24273A
      selection_background    #F4DBD6

      # Cursor colors
      cursor                  #F4DBD6
      cursor_text_color       #24273A

      # URL underline color when hovering with mouse
      url_color               #F4DBD6

      # Kitty window border colors
      active_border_color     #B7BDF8
      inactive_border_color   #6E738D
      bell_border_color       #EED49F

      # OS Window titlebar colors
      wayland_titlebar_color system
      macos_titlebar_color system

      # Tab bar colors
      active_tab_foreground   #181926
      active_tab_background   #C6A0F6
      inactive_tab_foreground #CAD3F5
      inactive_tab_background #1E2030
      tab_bar_background      #181926

      # Colors for marks (marked text in the terminal)
      mark1_foreground #24273A
      mark1_background #B7BDF8
      mark2_foreground #24273A
      mark2_background #C6A0F6
      mark3_foreground #24273A
      mark3_background #7DC4E4

      # The 16 terminal colors
      # black
      color0 #494D64
      color8 #5B6078

      # red
      color1 #ED8796
      color9 #ED8796

      # green
      color2  #A6DA95
      color10 #A6DA95

      # yellow
      color3  #EED49F
      color11 #EED49F

      # blue
      color4  #8AADF4
      color12 #8AADF4

      # magenta
      color5  #F5BDE6
      color13 #F5BDE6

      # cyan
      color6  #8BD5CA
      color14 #8BD5CA

      # white
      color7  #B8C0E0
      color15 #A5ADCB

      map ctrl+shift+p kitten hints --type path --program @
      map ctrl+shift+s kitten hints --type word --program @
      map ctrl+shift+l kitten hints --type line --program @

      symbol_map U+4E00-U+9FFF   Xiaolai Mono SC
      symbol_map U+3400-U+4DBF   Xiaolai Mono SC
      symbol_map U+20000-U+2A6DF Xiaolai Mono SC
      symbol_map U+2A700-U+2B73F Xiaolai Mono SC
      symbol_map U+2B740-U+2B81F Xiaolai Mono SC
      symbol_map U+2B820-U+2CEAF Xiaolai Mono SC
      symbol_map U+2CEB0-U+2EBEF Xiaolai Mono SC
      symbol_map U+30000-U+3134F Xiaolai Mono SC
      symbol_map U+F900-U+FAFF   Xiaolai Mono SC
      symbol_map U+2F800-U+2FA1F Xiaolai Mono SC
    '';
  };
  home.packages = with pkgs; [
    termpdfpy
    mdcat
  ];
}