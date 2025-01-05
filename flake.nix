{
  description = "NixOS and Home Manager configuration of niklas";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = inputs@{ nixpkgs, nixpkgs-unstable, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfreePredicate = pkg: nixpkgs.lib.getName pkg == "discord";
      };
      inherit (pkgs) lib;
      username = "niklas";
    in
    rec
    {
      nixosModules = lib.mapAttrs'
        (filename: _: { name = lib.strings.removeSuffix ".nix" filename; value = import ./nixosModules/${filename}; })
        (builtins.readDir ./nixosModules);

      nixosConfigurations.niks-xps = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [ ./machines/niks-xps ];
        specialArgs = { inherit inputs username nixosModules pkgs-unstable; };
      };

      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home.nix ];
        extraSpecialArgs = { inherit pkgs-unstable; };
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
