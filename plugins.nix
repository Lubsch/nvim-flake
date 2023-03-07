pkgs:
with pkgs.vimPlugins; {
  start = [
    nvim-treesitter
    nvim-lspconfig
    vim-commentary
    smart-pairs
    tex-conceal
    gruvbox
    asyncrun
    plenary
    telescope
    telescope-fzf-native
    mkdnflow
    vim-startuptime
    impatient
    filetype
    markdown-preview
  ];
  opt = [  ];
}
