#
#  flake.nix *
#   ├─ ./hosts
#   │   └─ default.nix
#   ├─ ./darwin
#   │   └─ default.nix
#   └─ ./nix
#       └─ default.nix
#

{
  description = "Nix, NixOS and Nix Darwin System Flake Configuration";

  inputs =
    {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; # Nix Packages (Default)
      # nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable"; # Unstable Nix Packages
      nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05"; # Unstable Nix Packages
      nixos-hardware.url = "github:nixos/nixos-hardware/master"; # Hardware Specific Configurations

      # Utilities for Mac App launchers (/Applications/Nix Trampolines/)
      mac-app-util.url = "github:hraban/mac-app-util";

      # User Environment Manager
      home-manager = {
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      # Unstable User Environment Manager
      # home-manager-unstable = {
      #   url = "github:nix-community/home-manager";
      #   inputs.nixpkgs.follows = "nixpkgs-unstable";
      # };

      # Stable User Environment Manager
      home-manager-stable = {
        url = "github:nix-community/home-manager/release-23.11";
        inputs.nixpkgs.follows = "nixpkgs-stable";
      };

      # MacOS Package Management
      darwin = {
        url = "github:lnl7/nix-darwin/master";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      # NUR Community Packages
      nur = {
        url = "github:nix-community/NUR";
        # Requires "nur.nixosModules.nur" to be added to the host modules
      };

      # Fixes OpenGL With Other Distros.
      nixgl = {
        url = "github:guibou/nixGL";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      # Neovim
      nixvim = {
        url = "github:nix-community/nixvim";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      # # Neovim
      # nixvim-stable = {
      #   url = "github:nix-community/nixvim/nixos-24.05";
      #   inputs.nixpkgs.follows = "nixpkgs-stable";
      # };

      # Emacs Overlays
      emacs-overlay = {
        url = "github:nix-community/emacs-overlay";
        flake = false;
      };

      # Nix-Community Doom Emacs
      doom-emacs = {
        url = "github:nix-community/nix-doom-emacs";
        inputs.nixpkgs.follows = "nixpkgs";
        inputs.emacs-overlay.follows = "emacs-overlay";
      };

      # Official Hyprland Flake
      hyprland = {
        url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
      };

      # Hyprspace
      hyprspace = {
        url = "github:KZDKM/Hyprspace";
        inputs.hyprland.follows = "hyprland";
      };

      # KDE Plasma User Settings Generator
      plasma-manager = {
        url = "github:pjones/plasma-manager";
        inputs.nixpkgs.follows = "nixpkgs";
        inputs.home-manager.follows = "nixpkgs";
      };

      nix-vscode-extensions = {
        url = "github:nix-community/nix-vscode-extensions";
        inputs.nixpkgs.follows = "nixpkgs";
      };
    };

  outputs =
    { self
    , nixpkgs
    , nixpkgs-stable
    , nixos-hardware
    , mac-app-util
    , home-manager
    , home-manager-stable
    , darwin
    , nur
    , nixgl
    , nixvim
    , doom-emacs
    , hyprland
    , hyprspace
    , plasma-manager
    , nix-vscode-extensions
    , ...
    } @ inputs:
    let
      # Variables Used In Flake
      vars = {
        user = "corey";
        location = "$HOME/.setup";
        terminal = "wezterm";
        editor = "nvim";
      };
    in
    {
      nixosConfigurations = (
        import ./hosts {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs nixpkgs-stable nixos-hardware home-manager nur nixvim doom-emacs hyprland hyprspace plasma-manager vars; # Inherit inputs
        }
      );

      darwinConfigurations = (
        import ./darwin {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs nixpkgs-stable mac-app-util home-manager darwin nixvim doom-emacs vars;
        }
      );

      homeConfigurations = (
        import ./nix {
          inherit (nixpkgs) lib;
          inherit inputs nixpkgs nixpkgs-stable home-manager nixgl vars;
        }
      );
    };
}