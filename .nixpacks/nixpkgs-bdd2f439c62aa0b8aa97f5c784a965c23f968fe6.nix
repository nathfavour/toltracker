{ }:

let pkgs = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/bdd2f439c62aa0b8aa97f5c784a965c23f968fe6.tar.gz") { overlays = [ (import (builtins.fetchTarball "https://github.com/railwayapp/nix-npm-overlay/archive/main.tar.gz")) ]; };
in with pkgs;
  let
    APPEND_LIBRARY_PATH = "${lib.makeLibraryPath [  ] }";
    myLibraries = writeText "libraries" ''
      export LD_LIBRARY_PATH="${APPEND_LIBRARY_PATH}:$LD_LIBRARY_PATH"
      
    '';
  in
    buildEnv {
      name = "bdd2f439c62aa0b8aa97f5c784a965c23f968fe6-env";
      paths = [
        (runCommand "bdd2f439c62aa0b8aa97f5c784a965c23f968fe6-env" { } ''
          mkdir -p $out/etc/profile.d
          cp ${myLibraries} $out/etc/profile.d/bdd2f439c62aa0b8aa97f5c784a965c23f968fe6-env.sh
        '')
        nodejs_18 npm-8_x
      ];
    }
