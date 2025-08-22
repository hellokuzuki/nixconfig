{ config, pkgs, ... }:

{
  # Use home-manager's i18n.inputMethod module (like the template)
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      addons = with pkgs; [
        fcitx5-gtk
        libsForQt5.fcitx5-qt
        fcitx5-chinese-addons
        fcitx5-rime
        fcitx5-pinyin-moegirl
        fcitx5-pinyin-zhwiki
      ];
      waylandFrontend = true;
    };
  };
  
  # Configure fcitx5 profile for Chinese input
  home.file.".config/fcitx5/profile" = {
    text = ''
      [Groups/0]
      # Group Name
      Name=Default
      # Layout
      Default Layout=au
      # Default Input Method
      DefaultIM=pinyin
      
      [Groups/0/Items/0]
      # Name
      Name=keyboard-au
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
  };
  
  # Configure fcitx5 hotkeys
  home.file.".config/fcitx5/config" = {
    text = ''
      [Hotkey]
      # Trigger Input Method
      TriggerKeys=
      # Enumerate when press trigger key repeatedly
      EnumerateWithTriggerKeys=True
      # Temporally switch between first and current Input Method
      AltTriggerKeys=
      
      [Hotkey/TriggerKeys]
      0=Control+space
      1=Zenkaku_Hankaku
      2=Hangul
      
      [Hotkey/AltTriggerKeys]
      0=Shift_L
      
      [Behavior]
      # Active By Default
      ActiveByDefault=False
      # Share Input State
      ShareInputState=No
      # Show preedit in application
      PreeditEnabledByDefault=True
      # Show Input Method Information when switch input method
      ShowInputMethodInformation=True
      # Default page size
      DefaultPageSize=5
      # Preload input method to be used by default
      PreloadInputMethod=True
    '';
  };
  
  # Configure pinyin settings
  home.file.".config/fcitx5/conf/pinyin.conf" = {
    text = ''
      # Page size
      PageSize=5
      # Enable Prediction
      Prediction=True
      # Prediction Size
      PredictionSize=10
      # Enable Emoji
      EmojiEnabled=True
      # Enable Chaizi
      ChaiziEnabled=True
      # Show preedit within application
      PreeditInApplication=True
      # Fix embedded preedit cursor at the beginning of the preedit
      PreeditCursorPositionAtBeginning=True
      # Use - to choose second candidate and = to choose third candidate
      SecondThirdCandidateKey=True
      # Commit current preedit when toggle
      CommitPreeditWhenToggle=True
      # First candidate as Preedit
      FirstCandidateAsPreedit=False
    '';
  };
}