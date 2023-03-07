{
  description = "A nice and simple portable neovim config by Lubsch";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      forAllSystems = nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed;
    in rec {

      apps = forAllSystems (system: {
        default = apps.${system}.nvim;

        nvim = {
          type = "app";
          program = "${packages.${system}.default}/bin/nvim";
        };
      });

      packages = forAllSystems (system:
        let
          pkgs = import nixpkgs { inherit system; };
        in {
          default = packages.${system}.neovim;

          neovim = pkgs.wrapNeovim pkgs.neovim-unwrapped {
            configure = {
              customRC = ''
                lua << EOF
                -- install all treesitter grammars without slowing down startup
                vim.opt.runtimepath:append("${pkgs.symlinkJoin {
                  name = "treesitter-parsers";
                  paths = pkgs.vimPlugins.nvim-treesitter.withAllGrammars.dependencies;
                } }")
                ${builtins.readFile ./init.lua}
                EOF
                ${builtins.readFile ./init.vim}
              '';
              packages.myVimPackage = {
                inherit (import ./plugins.nix pkgs) start opt;
              };
            };
          };
        }
      );
    };
}
