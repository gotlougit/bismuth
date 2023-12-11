{
  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      mkShell = pkgs.mkShell.override { stdenv = pkgs.stdenvAdapters.useMoldLinker pkgs.stdenv; };
    in
    {
      devShells.${system}.default = mkShell {
        name = "c_cpp_dev";
        shellHook = ''
          export _ZO_DATA_DIR="$(realpath ./.localzoxide)"
        '';
        buildInputs = [
          pkgs.pkg-config
          pkgs.gnumake
          pkgs.npm
          pkgs.cmake
          pkgs.reuse
          pkgs.libclang
          pkgs.pre-commit
        ];
      };
    };
}

