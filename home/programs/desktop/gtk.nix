{ config, pkgs, ... }:

{
  gtk = {
    enable = true;
    
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    
    cursorTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
    
    gtk3 = {
      extraConfig = {
        gtk-application-prefer-dark-theme = true;
      };
    };
    
    gtk4 = {
      extraConfig = {
        gtk-application-prefer-dark-theme = true;
      };
    };
  };
  
  # QT theme configuration to match GTK
  qt = {
    enable = true;
    platformTheme.name = "adwaita";
    style = {
      name = "adwaita-dark";
      package = pkgs.adwaita-qt;
    };
  };
  
  # Set environment variables for consistent theming
  home.sessionVariables = {
    GTK_THEME = "Adwaita-dark";
    QT_STYLE_OVERRIDE = "adwaita-dark";
  };
  
  # Configure dconf settings for GNOME applications
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "Adwaita-dark";
      icon-theme = "Papirus-Dark";
      cursor-theme = "Adwaita";
      enable-hot-corners = false;
    };
    
    # Additional dark mode settings
    "org/gnome/desktop/wm/preferences" = {
      theme = "Adwaita-dark";
    };
    
    "org/gnome/settings-daemon/plugins/color" = {
      night-light-enabled = false;  # Set to true if you want blue light filter
    };
  };
  
  # XDG portal configuration for dark mode
  xdg.portal = {
    enable = true;
    config.common = {
      default = ["gtk"];
      "org.freedesktop.impl.portal.Settings" = ["gtk"];
    };
  };
  
  # Create config files for Electron apps to use dark mode
  home.file = {
    ".config/electron-flags.conf".text = ''
      --enable-features=WebUIDarkMode
      --force-dark-mode
    '';
    
    ".config/electron13-flags.conf".text = ''
      --enable-features=WebUIDarkMode
      --force-dark-mode
    '';
    
    # Firefox dark mode preference
    ".mozilla/firefox/chrome/userChrome.css".text = ''
      @media (prefers-color-scheme: dark) {
        :root {
          --toolbar-bgcolor: #2b2a33 !important;
        }
      }
    '';
  };
}