#
#  Shared MacOS system configuration.
#

{ pkgs, vars, ... }:

{
  # don't want to bootstrap stuff I already have configs for. -ccj
  #imports = (import ./modules);

  imports = [
    ../modules/editors/nvim.nix
    ../modules/editors/vscodium.nix
  ];

  users.users.${vars.user} = {
    home = "/Users/${vars.user}";
    shell = pkgs.zsh;
  };

  environment = {
    variables = {
      EDITOR = "${vars.editor}";
      VISUAL = "${vars.editor}";
    };
    systemPackages = with pkgs; [
      ffmpeg
      mas # Mac App Store $ mas search <app>
      # reattach-to-user-namespace
    ];
  };

  services = {
    yabai = {
      enable = true;
      package = pkgs.yabai;
    };
    skhd.enable = true;
    sketchybar.enable = true;
    jankyborders = {
      enable = true;
      active_color = "gradient(top_right=0xD892B3F5,bottom_left=0xD8B3F592)";
      inactive_color = "0x00000000";
      width = 7.0;
    };
    # TODO: I had manually enabled this, need to turn it on here later.
    #karabiner-elements.enable = true;

    # https://docs.spotifyd.rs/config/File.html
    # spotifyd = {
    #   enable = true;
    #   settings = {
    #     bitrate = 320;
    #     # on_song_change_hook = "tell sketchybar";
    #     device_type = "computer";
    #
    #     password_cmd = "pass spotify";
    #     max_cache_size = 10000000000; # 10GB
    #   };
    # };
  };

  fonts.packages = [ pkgs.nerdfonts ];

  homebrew = {
    enable = true;
    onActivation = {
      upgrade = false;
      cleanup = "zap";
    };
    brews = [
      # sketchybar
      "switchaudio-osx"
      "nowplaying-cli"
    ];
    casks = [
      # sketchybar
      "sf-symbols"
      "font-sf-mono"
      "font-sf-pro"

      "1password"
      "1password-cli"

      # browsers
      "arc"
      "brave-browser"
      "firefox"

      # document manipulation / preview
      "qlmarkdown"
      "skim"

      # input systems
      "plover"
      "talon"

      # general usability
      "finicky" # url manager
      "karabiner-elements"
      "maccy" # clipboard manager
      "mos"
      # "blurred" # [blur unfocused apps](https://github.com/dwarvesf/Blurred)
      # "jordanbaird-ice" # [menu bar mgmt](https://github.com/dwarvesf/hidden)

      # audio / video
      "spotify"
      "vlc"

      # "aldente"
      # "appcleaner"
      # "firefox"
      # "moonlight"
      # "obs"
      # "plex"
      # "prusaslicer"
      # "raycast"
      # "stremio"
      # "vlc"
      # "canon-eos-utility"
      # "jellyfin-media-player"
    ];
    masApps = {
      # "wireguard" = 1451685025;
    };
  };

  # home-manager.users.${vars.user} = {
  #   home.stateVersion = "22.05";
  # };

  services.nix-daemon.enable = true;
  services.nix-daemon.logFile = "/var/log/nix-daemon.log";

  nix = {
    package = pkgs.nix;
    gc = {
      automatic = true;
      interval.Day = 7;
      options = "--delete-older-than 7d";
    };
    extraOptions = ''
      # auto-optimise-store = true
      experimental-features = nix-command flakes
    '';
  };

  system = {
    defaults = {
      NSGlobalDomain = {
        AppleKeyboardUIMode = 3; # Full Keyboard mode
        ApplePressAndHoldEnabled = false;

        # Keyboard Go Fast! https://apple.stackexchange.com/questions/10467/how-to-increase-keyboard-key-repeat-rate-on-os-x
        InitialKeyRepeat = 10;
        KeyRepeat = 1;
      };
    };

    stateVersion = 4;
  };
}
