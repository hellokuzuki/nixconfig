{
  pkgs,
  ...
}:
{
  programs.kitty = {
    enable = true;
    shellIntegration.enableFishIntegration = true;
    settings = {
      font_family = "Maple Mono NF CN";
      font_size = 16;
      window_padding_width = "10 20 10 20";
      cursor_trail = 1;
      cursor_trail_start_threshold = 0;
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";
      background_opacity = "1.0";
      dynamic_background_opacity = "true";
      term = "xterm-256color";
    };
    extraConfig = ''
      ## name:     Catppuccin Kitty Mocha
      ## author:   Catppuccin Org
      ## license:  MIT
      ## upstream: https://github.com/catppuccin/kitty/blob/main/themes/mocha.conf
      ## blurb:    Soothing pastel theme for the high-spirited!

      # The basic colors
      foreground              #cdd6f4
      background              #1e1e2e
      selection_foreground    #1e1e2e
      selection_background    #f5e0dc

      # Cursor colors
      cursor                  #f5e0dc
      cursor_text_color       #1e1e2e

      # URL underline color when hovering with mouse
      url_color               #f5e0dc

      # Kitty window border colors
      active_border_color     #b4befe
      inactive_border_color   #6c7086
      bell_border_color       #f9e2af

      # OS Window titlebar colors
      wayland_titlebar_color system
      macos_titlebar_color system

      # Tab bar colors
      active_tab_foreground   #11111b
      active_tab_background   #cba6f7
      inactive_tab_foreground #cdd6f4
      inactive_tab_background #181825
      tab_bar_background      #11111b

      # Colors for marks (marked text in the terminal)
      mark1_foreground #1e1e2e
      mark1_background #b4befe
      mark2_foreground #1e1e2e
      mark2_background #cba6f7
      mark3_foreground #1e1e2e
      mark3_background #74c7ec

      # The 16 terminal colors

      # black
      color0 #45475a
      color8 #585b70

      # red
      color1 #f38ba8
      color9 #f38ba8

      # green
      color2  #a6e3a1
      color10 #a6e3a1

      # yellow
      color3  #f9e2af
      color11 #f9e2af

      # blue
      color4  #89b4fa
      color12 #89b4fa

      # magenta
      color5  #f5c2e7
      color13 #f5c2e7

      # cyan
      color6  #94e2d5
      color14 #94e2d5

      # white
      color7  #bac2de
      color15 #a6adc8

      # Hints - improved patterns for better detection
      map ctrl+shift+p kitten hints --type path
      map ctrl+shift+h kitten hints --type hash --program @
      map ctrl+shift+s kitten hints --type word --program @
      map ctrl+shift+l kitten hints --type line --program @
      map ctrl+shift+u kitten hints --type url
      
      # Window management
      map ctrl+q close_window

      symbol_map U+4E00-U+9FFF   XiaolaiMonoSC
      symbol_map U+3400-U+4DBF   XiaolaiMonoSC
      symbol_map U+20000-U+2A6DF XiaolaiMonoSC
      symbol_map U+2A700-U+2B73F XiaolaiMonoSC
      symbol_map U+2B740-U+2B81F XiaolaiMonoSC
      symbol_map U+2B820-U+2CEAF XiaolaiMonoSC
      symbol_map U+2CEB0-U+2EBEF XiaolaiMonoSC
      symbol_map U+30000-U+3134F XiaolaiMonoSC
      symbol_map U+F900-U+FAFF   XiaolaiMonoSC
      symbol_map U+2F800-U+2FA1F XiaolaiMonoSC
    '';
  };
  home.packages = with pkgs; [
    termpdfpy
    mdcat
  ];
}