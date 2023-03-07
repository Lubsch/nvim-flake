-- Improve startup time
require('impatient')

require("gruvbox").setup({ italic = false })

-- Autopair
require 'nvim-autopairs':setup {}

-- Mkdnflow (mostly default settings)
-- require('mkdnflow').setup({
--     modules = {
--         bib = true,
--         buffers = true,
--         conceal = true,
--         cursor = true,
--         folds = false,
--         links = true,
--         lists = true,
--         maps = true,
--         paths = true,
--         tables = true
--     },
--     filetypes = {md = true, rmd = true, markdown = true},
--     create_dirs = true,             
--     perspective = {
--         priority = 'root',
--         fallback = 'current',
--         root_tell = 'index.md',
--         nvim_wd_heel = true
--     },    
--     wrap = false,
--     bib = {
--         default_path = nil,
--         find_in_root = true
--     },
--     silent = false,
--     links = {
--         style = 'wiki',
--         conceal = true,
--         implicit_extension = nil,
--         transform_implicit = false,
--         transform_explicit = function(text)
--             text = text:gsub(" ", "-")
--             text = text:lower()
--             text = os.date('%Y-%m-%d_')..text
--             return(text)
--         end
--     },
--     to_do = {
--         symbols = {' ', 'X'},
--         update_parents = true,
--         not_started = ' ',
--         in_progress = '-',
--         complete = 'X'
--     },
--     tables = {
--         trim_whitespace = true,
--         format_on_move = true,
--         auto_extend_rows = false,
--         auto_extend_cols = false
--     },
--     mappings = {
--         MkdnEnter = {{'n', 'v'}, '<CR>'},
--         MkdnTab = false,
--         MkdnSTab = false,
--         MkdnNextLink = {'n', '<Tab>'},
--         MkdnPrevLink = {'n', '<S-Tab>'},
--         MkdnNextHeading = {'n', ']]'},
--         MkdnPrevHeading = {'n', '[['},
--         MkdnGoBack = {'n', '<BS>'},
--         MkdnGoForward = {'n', '<Del>'},
--         MkdnFollowLink = false, -- see MkdnEnter
--         MkdnDestroyLink = {'n', '<M-CR>'},
--         MkdnTagSpan = {'v', '<M-CR>'},
--         MkdnMoveSource = {'n', '<F2>'},
--         MkdnYankAnchorLink = {'n', 'ya'},
--         MkdnYankFileAnchorLink = {'n', 'yfa'},
--         MkdnIncreaseHeading = {'n', '+'},
--         MkdnDecreaseHeading = {'n', '-'},
--         MkdnToggleToDo = {{'n', 'v'}, '<C-Space>'},
--         MkdnNewListItem = false,
--         MkdnExtendList = false,
--         MkdnUpdateNumbering = {'n', '<leader>nn'},
--         MkdnTableNextCell = {'i', '<Tab>'},
--         MkdnTablePrevCell = {'i', '<S-Tab>'},
--         MkdnTableNextRow = false,
--         MkdnTablePrevRow = {'i', '<M-CR>'},
--         MkdnTableNewRowBelow = {{'n', 'i'}, '<leader>ir'},
--         MkdnTableNewRowAbove = {{'n', 'i'}, '<leader>iR'},
--         MkdnTableNewColAfter = {{'n', 'i'}, '<leader>ic'},
--         MkdnTableNewColBefore = {{'n', 'i'}, '<leader>iC'},
--         MkdnFoldSection = {'n', '<leader>f'},
--         MkdnUnfoldSection = {'n', '<leader>F'}
--     }
-- })

-- lsp
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
-- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<leader>=', vim.lsp.buf.formatting, bufopts)
end

local lspconfig = require('lspconfig')
lspconfig.rnix.setup{ on_attach = an_attach } -- nix
lspconfig.ccls.setup {
    on_attach = on_attach,
    init_options = {
        cache = {
            directory = "$XDG_CACHE_HOME/ccls";
        }
    }
}

-- treesitter
vim.opt.runtimepath:append("$HOME/.local/share/treesitter")
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  parser_install_dir = "$XDG_DATA_HOME/treesitter",

  highlight = {
    enable = true,
  },
}
