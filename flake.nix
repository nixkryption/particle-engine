{
  description = "Particle engine is a engine for particle";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
  };

  outputs = { self, nixpkgs }: let
    systems = [ "x86_64-linux" "aarch64-darwin" ];
    forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f nixpkgs.legacyPackages.${system});
  in {
    # packages = forAllSystems (pkgs: {
    #   default = pkgs.hello;
    # });

    # apps = forAllSystems (pkgs: {
    #   default = {
    #     type = "app";
    #     program = "${pkgs.hello}/bin/hello";
    #   };
    # });

    devShells = forAllSystems (pkgs: {
      default = pkgs.mkShell {
        buildInputs = with pkgs; [
          zig
          fish
          zls
          sdl3
        ];
        shellHook = ''
          alias vi='nvim'
          export SHELL=${pkgs.fish}/bin/fish
          export SDL3_INCLUDE_DIR=${pkgs.sdl3}/include/SDL3
          export SDL3_LIB_DIR=${pkgs.sdl3}/lib
          exec ${pkgs.fish}/bin/fish
        '';
      };
    });

  };
}
