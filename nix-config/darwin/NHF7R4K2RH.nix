#
#  Specific system configuration settings for Smartsheet MacbookPro M1 Pro (NHF7R4K2RH)
#

{ pkgs, vars, ... }:

{
  imports = [
    ../modules/smar/zscalar_root_ca.nix
  ];

  environment = {
    systemPackages = with pkgs; [
      ## dependencies for node-canvas
      pkg-config
      cairo
      pango
      libpng
      libjpeg
      giflib
      librsvg
      pixman
      ## /dependencies for node-canvas

      imagemagick
      glab
      volta
      wezterm
      yarn
    ];
  };

  homebrew = {
    brews = [
      # development tools
      "podman-compose"
    ];
    casks = [
      "discord"
      "ticktick"
      "spotmenu"

      # development tools
      "insomnia"
      "podman-desktop"
      "xscope"

      # graphics
      "gimp"
      "inkscape"

      # Knowledge
      "nvalt"
    ];
    masApps = {
      "Microsoft Remote Desktop" = 1295203466;
      "Sim Daltonism" = 693112260;
      "Yubico Authenticator" = 1497506650;
      # "Xcode" = 497799835;
    };
  };

  system = {
    defaults = {
      NSGlobalDomain = {
        AppleShowAllExtensions = true;
        # AppleSpacesSwitchOnActivate = false; # don't switch spaces when app closes
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        "com.apple.mouse.tapBehavior" = 1;
        "com.apple.trackpad.enableSecondaryClick" = true;
        # "com.apple.keyboard.fnState" = true;
      };
      dock = {
        "appswitcher-all-displays" = true;
        autohide = true;
        autohide-delay = 0.2;
        autohide-time-modifier = 0.1;
        magnification = false;
        mineffect = "scale";
        # minimize-to-application = true;
        orientation = "right";
        showhidden = false;
        show-recents = false;
        tilesize = 25;
      };
      finder = {
        ShowPathbar = true;
        ShowStatusBar = true;
      };
      trackpad = {
        Clicking = true;
        TrackpadRightClick = true;
      };
      # universalaccess = {
      #   reduceMotion = true;
      # };


      CustomUserPreferences = {
        # Settings of plist in ~/Library/Preferences/
        "com.apple.finder" = {
          # Set home directory as startup window
          NewWindowTargetPath = "file:///Users/${vars.user}/";
          NewWindowTarget = "PfHm";
          # Set search scope to directory
          FXDefaultSearchScope = "SCcf";
          # Multi-file tab view
          FinderSpawnTab = true;
        };
        "com.apple.desktopservices" = {
          # Disable creating .DS_Store files in network an USB volumes
          DSDontWriteNetworkStores = true;
          DSDontWriteUSBStores = true;
        };
        "com.apple.WindowManager" = {
          EnableStandardClickToShowDesktop = false;
        };
        # Show battery percentage
        "~/Library/Preferences/ByHost/com.apple.controlcenter".BatteryShowPercentage = true;
        # Privacy
        "com.apple.AdLib".allowApplePersonalizedAdvertising = false;
      };
      CustomSystemPreferences = {
        # ~/Library/Preferences/
      };
    };
  };
}
