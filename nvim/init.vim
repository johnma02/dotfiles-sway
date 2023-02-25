call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')
Plug 'tpope/vim-dispatch', {'branch': 'release'}
Plug 'tpope/vim-pathogen', {'branch': 'main'}
Plug 'vim-scripts/errormarker.vim'
Plug 'andweeb/presence.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'Shatur/neovim-ayu'
Plug 'arcticicestudio/nord-vim'
Plug 'lervag/vimtex'
Plug 'SirVer/ultisnips'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'nvim-lualine/lualine.nvim'
call plug#end()
filetype plugin indent on
set completeopt=menu,menuone,noselect
set number

let g:vimtex_view_method='zathura'


lua <<EOF
require("mason").setup()
require("mason-lspconfig").setup()
require("lualine").setup{
    options={
        icons_enabled=false,
        theme="ayu_mirage",
        section_separators = '', component_separators = ''
    }
}
local cmp = require'cmp'

cmp.setup({
    snippet = {
    expand = function(args)
        vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
    },
    window = {
        --completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    experimental = {
        ghost_text = true,
    },


    mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<TAB>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'ultisnips' }, -- For ultisnips users.
    }, {
      { name = 'buffer' },
    })
    })

  -- Set configuration for specific filetype.
    cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
    })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
    })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
    })
  -- Set up lspconfig.

    require("lspconfig")['pylsp'].setup {}
    require("lspconfig")['clangd'].setup {}

EOF

let g:vimtex_compiler_method = 'latexmk'

let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

colorscheme ayu-mirage

set relativenumber
set cindent
set showmatch
set softtabstop=4
set shiftwidth=4
set expandtab
set termguicolors
syntax on
set expandtab
set nowrap
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O


setlocal spell
set spelllang=nl,en_gb
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

autocmd BufNewFile *.cpp 0r ~/.config/nvim/template.cpp
autocmd BufNewFile *.tex 0r ~/.config/nvim/template.tex

autocmd FileType Makefile set expandtab=0

set makeprg=g++-12\ -std=c++17\ -o\ %:r\ %\
autocmd filetype cpp nnoremap <F9> :w <bar> Make <CR>
autocmd filetype cpp nnoremap <F10> :vs<bar>:terminal ./%:r<CR>
autocmd filetype cpp nnoremap <F11> :!./%:r<CR>
execute pathogen#infect()
