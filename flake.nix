{
  description = "Haunter";

  inputs = {
    nixpkgs.url      = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url  = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlays = [];
        pkgs = import nixpkgs {
          inherit system overlays;
        };

        app = pkgs.buildGoModule {
          pname = "haunter";
          version = "0.0.1";
          src = ./.;

          vendorHash = "sha256-8lWgRCDFN6ifbqvz+B/H9GSZC8F5KuRyjWB1Y3RGTts=";

          CGO_ENABLED = false;
        };
      in
      {
        packages.default = app;

        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            go_1_20
            gopls
          ];
        };
      }
    );
}
