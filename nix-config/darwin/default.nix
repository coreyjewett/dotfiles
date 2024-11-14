#
#  These are the different profiles that can be used when building on MacOS
#
#  flake.nix
#   └─ ./darwin
#       ├─ default.nix *
#       ├─ darwin-configuraiton.nix
#       └─ <host>.nix
#

{ inputs, nixpkgs, nixpkgs-stable, darwin, mac-app-util, home-manager, nixvim, vars, ... }:

let
  systemConfig = system: {
    system = system;
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    stable = import nixpkgs-stable {
      inherit system;
      config.allowUnfree = true;
    };
  };
in
{
  # # MacBook8,1 "Core M" 1.2 12" (2015) A1534
  # MacBookIntel =
  #   let
  #     inherit (systemConfig "x86_64-darwin") system pkgs stable;
  #   in
  #   darwin.lib.darwinSystem {
  #     inherit system;
  #     specialArgs = { inherit inputs system pkgs stable vars; };
  #     modules = [
  #       ./darwin-configuration.nix
  #       ./intel.nix
  #       ../modules/programs/kitty.nix
  #       nixvim.nixDarwinModules.nixvim
  #       home-manager.darwinModules.home-manager
  #       {
  #         home-manager.useGlobalPkgs = true;
  #         home-manager.useUserPackages = true;
  #       }
  #     ];
  #   };

  # Work Laptop
  NHF7R4K2RH =
    let
      inherit (systemConfig "aarch64-darwin") system pkgs stable;
      extendedVars = vars // { user = "cjewett"; };
    in
    darwin.lib.darwinSystem {
      inherit system;
      specialArgs = { inherit inputs system pkgs stable; vars = extendedVars; };
      modules = [
        ./darwin-configuration.nix
        ./NHF7R4K2RH.nix
        ../common.nix
        nixvim.nixDarwinModules.nixvim
        # home-manager.darwinModules.home-manager
        # {
        #   home-manager.useGlobalPkgs = true;
        #   home-manager.useUserPackages = true;
        # }
        mac-app-util.darwinModules.default
      ];
    };
}
