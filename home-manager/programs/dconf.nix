{ config, lib, ... }:

{
  # To set user avatar/login picture, run after rebuild:
  # sudo usermod -c "mark" -s /bin/fish mark
  # sudo mkdir -p /var/lib/AccountsService/users
  # echo -e "[User]\nIcon=${config.home.homeDirectory}/nixconfig/wallpapers/solar.png" | sudo tee /var/lib/AccountsService/users/mark

  dconf.settings = {
    "org/gnome/desktop/background" = {
      # Using relative paths from home directory
      # Place your wallpaper images in ~/nixconfig/wallpapers/
      # Then reference them like below
      
      # Wallpaper for light mode
      picture-uri = "file://${config.home.homeDirectory}/nixconfig/wallpapers/solar.png";
      
      # Wallpaper for dark mode (optional, can use same as light mode)
      picture-uri-dark = "file://${config.home.homeDirectory}/nixconfig/wallpapers/solar.png";
      
      # How to display the wallpaper
      # Options: none, wallpaper, centered, scaled, stretched, zoom, spanned
      picture-options = "zoom";
    };
    
    "org/gnome/desktop/screensaver" = {
      # Lock screen wallpaper (optional)
      picture-uri = "file://${config.home.homeDirectory}/nixconfig/wallpapers/solar.png";
      picture-options = "zoom";
    };
  };
}