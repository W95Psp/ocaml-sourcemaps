{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = {
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
        };
        sourcemap = pkgs.ocamlPackages.buildDunePackage {
          pname = "sourcemap";
          version = "0.1";
          src = ./.;
          propagatedBuildInputs = with pkgs.ocamlPackages; [
            base
            ppx_inline_test
            ppxlib
            ppx_deriving
            ppx_yojson_conv
          ];
          duneVersion = "3";
          minimalOCamlVersion = "4.08";
          doCheck = false;
        };
      in {
        packages.default = sourcemap;
        devShells.default = pkgs.mkShell {
          inputsFrom = [sourcemap];
          packages = [pkgs.ocamlformat pkgs.ocamlPackages.utop];
        };
      }
    );
}
