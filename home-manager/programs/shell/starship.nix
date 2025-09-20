{ config, ... }:

{
  programs.starship = {
    enable = true;
    settings = {
      format = "$directory$git_branch$git_status$time\n$character ";

      palette = "catppuccin-mocha";

      palettes.catppuccin-mocha = {
        rosewater = "#f5e0dc";
        flamingo = "#f2cdcd";
        pink = "#f5c2e7";
        mauve = "#cba6f7";
        red = "#f38ba8";
        maroon = "#eba0ac";
        peach = "#fab387";
        yellow = "#f9e2af";
        green = "#a6e3a1";
        teal = "#94e2d5";
        sky = "#89dceb";
        sapphire = "#74c7ec";
        blue = "#89b4fa";
        lavender = "#b4befe";
        text = "#cdd6f4";
        subtext1 = "#bac2de";
        subtext0 = "#a6adc8";
        overlay2 = "#9399b2";
        overlay1 = "#7f849c";
        overlay0 = "#6c7086";
        surface2 = "#585b70";
        surface1 = "#45475a";
        surface0 = "#313244";
        base = "#1e1e2e";
        mantle = "#181825";
        crust = "#11111b";
      };

      character = {
        format = "$symbol ";
        success_symbol = "[╰─](bold mauve)[ ](bold mauve)";
        error_symbol = "[╰─](bold mauve)[ ](bold red)";
        vimcmd_symbol = "[╰─](bold mauve)[ ](bold teal)";
        vimcmd_visual_symbol = "[╰─](bold mauve)[ ](bold blue)";
        vimcmd_replace_symbol = "[╰─](bold mauve)[ ](bold yellow)";
        vimcmd_replace_one_symbol = "[╰─](bold mauve)[ ](bold yellow)";
      };

      container = {
        format = " [$symbol $name]($style) ";
        symbol = " ";
        style = "red bold";
        disabled = false;
      };

      directory = {
        format = "[╭─ $path ]($style)";
        style = "bold mauve";
        truncation_length = 3;
        truncation_symbol = "…/";
        substitutions = {
          Documents = "󰈙";
          Pictures = " ";
        };
      };

      git_branch = {
        format = "[](fg:base)[ $symbol $branch ]($style)[](fg:base) ";
        style = "bg:base fg:teal";
        symbol = " ";
      };

      git_status = {
        disabled = false;
        style = "fg:red";
        format = "([$all_status$ahead_behind]($style))";
        up_to_date = "[ 󰋑 ](fg:mauve)";
        untracked = "[?($count)](fg:yellow)";
        stashed = "[$](fg:mauve)";
        modified = "[!($count)](fg:yellow)";
        renamed = "[»($count)](fg:mauve)";
        deleted = "[✘($count)](style)";
        staged = "[++($count)](fg:yellow)";
        ahead = "[⇡($count)](fg:teal)";
        diverged = "⇕[[](fg:mauve)[⇡($ahead_count)](fg:teal)[⇣($behind_count)](fg:rosewater)[\\]](fg:mauve)";
        behind = "[⇣($count)](fg:rosewater)";
      };

      time = {
        disabled = false;
        format = " [](fg:base)[ $time 󰧱 ]($style)[](fg:base)";
        style = "bg:base fg:mauve";
        time_format = "%H:%M";
        use_12hr = true;
      };

      username = {
        disabled = false;
        format = "[](fg:base)[ 󰧱 $user ]($style)[](fg:base) ";
        show_always = true;
        style_root = "bg:base fg:mauve";
        style_user = "bg:base fg:mauve";
      };

      # Languages
      c = {
        style = "bg:base fg:blue";
        format = " [](fg:base)[ $symbol$version ]($style)[](fg:base)";
        disabled = false;
        symbol = " ";
      };

      elixir = {
        style = "bg:base fg:blue";
        format = " [](fg:base)[ $symbol$version ]($style)[](fg:base)";
        disabled = false;
        symbol = " ";
      };

      elm = {
        style = "bg:base fg:blue";
        format = " [](fg:base)[ $symbol$version ]($style)[](fg:base)";
        disabled = false;
        symbol = " ";
      };

      golang = {
        style = "bg:base fg:blue";
        format = " [](fg:base)[ $symbol$version ]($style)[](fg:base)";
        disabled = false;
        symbol = " ";
      };

      haskell = {
        style = "bg:base fg:blue";
        format = " [](fg:base)[ $symbol$version ]($style)[](fg:base)";
        disabled = false;
        symbol = " ";
      };

      java = {
        style = "bg:base fg:blue";
        format = " [](fg:base)[ $symbol$version ]($style)[](fg:base)";
        disabled = false;
        symbol = " ";
      };

      julia = {
        style = "bg:base fg:blue";
        format = " [](fg:base)[ $symbol$version ]($style)[](fg:base)";
        disabled = false;
        symbol = " ";
      };

      nodejs = {
        style = "bg:base fg:blue";
        format = " [](fg:base)[ $symbol$version ]($style)[](fg:base)";
        disabled = false;
        symbol = "󰎙 ";
      };

      nim = {
        style = "bg:base fg:blue";
        format = " [](fg:base)[ $symbol$version ]($style)[](fg:base)";
        disabled = false;
        symbol = "󰆥 ";
      };

      rust = {
        style = "bg:base fg:blue";
        format = " [](fg:base)[ $symbol$version ]($style)[](fg:base)";
        disabled = false;
        symbol = " ";
      };

      scala = {
        style = "bg:base fg:blue";
        format = " [](fg:base)[ $symbol$version ]($style)[](fg:base)";
        disabled = false;
        symbol = " ";
      };

      python = {
        style = "bg:base fg:blue";
        format = " [](fg:base)[ $symbol$version ]($style)[](fg:base)";
        disabled = false;
        symbol = " ";
      };

      nix_shell = {
        format = "via [$symbol$state( ($name))]($style) ";
        symbol = "󱄅 ";
        style = "bold teal";
        impure_msg = "impure";
        pure_msg = "pure";
        unknown_msg = "";
        disabled = false;
        heuristic = false;
      };

      conda = {
        style = "bg:surface0 fg:blue";
        format = " [](fg:surface0)[ $symbol$environment ]($style)[](fg:surface0)";
        disabled = false;
        symbol = "🅒 ";
      };
    };
  };
}