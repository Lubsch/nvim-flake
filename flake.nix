{
  description = "A nice and simple portable neovim config by Lubsch";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      forAllSystems = nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed;
      pkgs = forAllSystems (system: import nixpkgs { inherit system; });
    in rec {

      apps = forAllSystems (system: {
        default = apps.${system}.nvim;

        nvim = {
          type = "app";
          program = "${packages.default}/bin/nvim";
        };
      });

      packages = forAllSystems (system: {
        default = packages.${system}.neovim;

        neovim = pkgs.wrapNeovim pkgs.neovim-unwrapped {
          configure = {
            customRC = builtins.readFile ./init.vim;
            packages.myVimPackage =  with pkgs.vimPlugins; {
              start = import ./startPlugins.nix;
              opt = import ./optPlugins.nix;
            };
          };
        };
      });

    };
}
