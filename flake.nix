{
  description = "NixOS and Home Manager configuration of niklas";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    nixos-hardware = {
        url = "github:NixOS/nixos-hardware/master";
        inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, nixpkgs-unstable, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      pkgs-unstable = import nixpkgs-unstable { inherit system; };
      inherit (pkgs) lib;
      username = "niklas";
    in
    rec
    {
      inherit pkgs pkgs-unstable;

      nixosModules = lib.mapAttrs'
        (filename: _: { name = lib.strings.removeSuffix ".nix" filename; value = import ./nixosModules/${filename}; })
        (builtins.readDir ./nixosModules);

      nixosConfigurations = {
        niks-xps = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [ ./machines/niks-xps ];
          specialArgs = { inherit inputs username nixosModules pkgs-unstable; };
        };
        niks-fw = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [ ./machines/niks-fw ];
          specialArgs = { inherit inputs username nixosModules pkgs-unstable; };
        };
      };

      homeConfigurations = {
        "niklas@niks-fw" = home-manager.lib.homeManagerConfiguration {
          pkgs = pkgs-unstable;
          modules = [ ./home.nix ./homeModules/niri.nix ];
        };
        "niklas@BETAL207479" = home-manager.lib.homeManagerConfiguration {
          pkgs = pkgs-unstable;
          modules = [ ./home.nix ./homeModules/ubuntu.nix ];
        };
      };

      devShells.${system}.default = pkgs.mkShell {
        packages = [
          (pkgs.python3.withPackages (ps: with ps; [
            python-lsp-server
            pylsp-mypy
            pylsp-rope
            python-lsp-black
            isort
            python-lsp-ruff
            qtile
          ]))
        ];
      };
    };
}
