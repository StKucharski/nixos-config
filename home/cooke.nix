{ lib, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  home = {
    packages = with pkgs; [
      hello
      fastfetch
      tree
      wl-clipboard
      zsh-powerlevel10k 
      rnote
      python3
      python313Packages.grip
      github-desktop
      git-lfs
      discord
      playerctl
    ];
    
    file = {
      ".config/sway/config".source = ./sway/conf;
      ".config/udiskie/config.yml".source = ./udiskie/conf;
      ".config/gtk-3.0/settings.ini".source = ./gtk/conf;
      ".config/gtk-4.0/settings.ini".source = ./gtk/conf;
      ".local/bin/powermenu.sh" = {
         source = ./sway/power_button.sh;
         executable = true;
      };
      ".config/waybar/config".source = ./waybar/conf.jsonc;
      ".config/waybar/style.css".source = ./waybar/style.css;
      ".config/waybar/scripts" = {
        source = ./waybar/scripts;
        recursive = true;
      };
    };
    
    pointerCursor = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
      size = 32;
      x11 = {
        enable = true;
        defaultCursor = "Adwaita";
      };
      sway.enable = true;
    };

    stateVersion = "25.05";
  };

  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "IBM Plex Mono:size=11";
      };
    };
  };

  programs.zsh = {
    enable = true;

    enableCompletion = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      theme = "powerlevel10k";
      plugins = [ "git" "z" "fzf" ];
      custom = "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k";
    };

    initContent = ''
      [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
    '';

    shellAliases = {
      ll = "ls -la";
      gs = "git status";
      tree = "tree --filesfirst";
    };

  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.wofi = {
    enable = true;
    settings = {
      width = 400;
      location = "center";
      prompt = "";
      allow_markup = true;
      always_parse_args = true;
    };
    style = ''
      window {
        background-color: rgba(40, 40, 40, 0.85);     
      }
      #input {
        margin: 5px;
        border: 2px;
      }

      #inner-box {
        margin: 5px;
        border: 2px;
      }

      #outer-box {
        margin: 10px;
        border: 4px;
        padding: 10px;
      }

      #scroll {
        margin: 5px;
        border: 2px;
      }

      #text {
        margin: 5px;
        border: 2px;
      }
    '';
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      ms-python.python
      ms-vscode.cpptools
      redhat.java
      vscjava.vscode-java-pack
      dbaeumer.vscode-eslint
    ];
  };

}