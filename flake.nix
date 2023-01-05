{
  # inspired by: https://github.com/jlesquembre/clj-demo-project/blob/master/flake.nix
  description = "A hugo flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    devshell.url = "github:numtide/devshell";
  };
  outputs = { self, nixpkgs, flake-utils, devshell }:

    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            devshell.overlay
          ];
        };
      in
      {
        devShells.default =
          pkgs.devshell.mkShell {
            packages = [
              pkgs.go
              pkgs.hugo
              pkgs.nodejs
              pkgs.nodePackages.npm
              pkgs.nodePackages.postcss
              pkgs.nodePackages.postcss-cli
              pkgs.nodePackages.autoprefixer
            ];
          };
      });

}
