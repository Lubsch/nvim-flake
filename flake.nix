{
  description = "A nice and simple portable neovim config by Lubsch";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      forAllSystems = nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed;
      pkgs = forAllSystems (system: import nixpkgs { inherit system; });
      luaRC = builtins.readFile ./init.vim;
      vimRC = builtins.readFile ./init.lua;
      plugins = import ./plugins.nix pkgs;
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
            customRC = ''
              ${vimRC}
              lua << EOF
              ${luaRC}
              EOF
            '';
            packages.myVimPackage =  with pkgs.vimPlugins; {
              start = import ./startPlugins.nix pkgs;
              opt = import ./optPlugins.nix pkgs;
            };
          };
        };
      });

    };
}
