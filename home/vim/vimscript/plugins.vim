scriptencoding utf-8

let g:plug_shallow      = 0
let g:plug_window       = 'enew'
let g:plug_pwindow      = 'vertical rightbelow new'
let g:polyglot_disabled = ['git', 'gitcommit', 'markdown']

call plug#begin()

" helpful functions {{{ "
  Plug 'tpope/vim-unimpaired'
  Plug 'AndrewRadev/deleft.vim',    { 'on': 'Deleft' }
  Plug 'AndrewRadev/splitjoin.vim', { 'on': ['SplitjoinSplit', 'SplitjoinJoin']}
  Plug 'AndrewRadev/switch.vim',    { 'on': ['Switch', 'SwitchReverse', '<Plug>switch'] }
  Plug 'SidOfc/mkdx'
  Plug 'rstacruz/vim-xtract',       { 'on': 'Xtract' }
" }}} helpful functions "

" text objects {{{ "
  Plug 'coderifous/textobj-word-column.vim'
  Plug 'kana/vim-textobj-entire'
  Plug 'kana/vim-textobj-indent'
  Plug 'kana/vim-textobj-line'
  Plug 'kana/vim-textobj-user'
  Plug 'jceb/vim-textobj-uri'
  Plug 'somini/vim-textobj-fold'
  Plug 'glts/vim-textobj-indblock'
" }}} text objects "

" hmm {{{

" }}} hmm

" looks and colorschemes {{{ "
  " colors {{{ "
  Plug 'pgavlin/pulumi.vim'
  Plug 'nanotech/jellybeans.vim'
  Plug 'cocopon/iceberg.vim'
  " }}} colors "

  " Plug 'camspiers/animate.vim'
  " Plug 'camspiers/lens.vim'
  Plug 'ntpeters/vim-better-whitespace'
  Plug 'pacha/vem-statusline'

  Plug 'junegunn/limelight.vim'
  Plug 'junegunn/goyo.vim'

  Plug 'iamcco/markdown-preview.nvim'

  Plug 'romainl/vim-cool'
  Plug 'AndrewRadev/multichange.vim'
  Plug 'dense-analysis/ale'
  Plug 'liuchengxu/vim-which-key'
  Plug 'machakann/vim-sandwich'
  Plug 'stsewd/gx-extended.vim'    " TODO: configure me!
  Plug 'tpope/vim-commentary'

  Plug 'raghur/vim-ghost', {'do': ':GhostInstall'}

  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'
  " Plug 'kshenoy/vim-signature'

  Plug 'sickill/vim-pasta'
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
  Plug 'https://gitlab.com/garyh/deoplete-gitlab'

  Plug 'fszymanski/deoplete-emoji'

  Plug 'hrsh7th/vim-vsnip'
  Plug 'hrsh7th/vim-vsnip-integ'
" }}} completion and snippets "

" this should be in standard neovim {{{ "
  Plug 'ryanoasis/vim-devicons'
  Plug 'kana/vim-niceblock'
  Plug 'mhinz/vim-sayonara',    { 'on': 'Sayonara' }
  Plug 'takac/vim-commandcaps'
  Plug 'tpope/vim-abolish'
  Plug 'tpope/vim-eunuch'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-rsi'

call plug#end()

" map <silent> <leader>tt :call checkbox#ToggleCB()<cr>
" map <silent> <leader>tt :ToggleCB()<cr>

" graveyard:
" Plug 'reedes/vim-pencil'
" Plug 'abdalrahman-ali/vim-remembers'
" Plug 'tpope/vim-fugitive'
" Plug 'shumphrey/fugitive-gitlab.vim'
" Plug 'keith/rspec.vim'
" Plug 'lambdalisue/nerdfont.vim'
" Plug 'sainnhe/artify.vim'
" Plug 'tjdevries/colorbuddy.nvim'
" Plug 'tpope/vim-bundler', ruby_filetypes
" Plug 'tpope/vim-endwise', ruby_filetypes
" Plug 'tpope/vim-rake',    ruby_filetypes
" Plug 'wsdjeg/vim-fetch'
" Plug 'adriaanzon/vim-textobj-matchit'
" Plug 'Julian/vim-textobj-variable-segment'
" Plug 'hoob3rt/lualine.nvim'
" Plug 'editorconfig/editorconfig-vim' " Slow.

" Plug 'eemed/sitruuna.vim'
" Plug 'kyazdani42/blue-moon'
" Plug 'romgrk/doom-one.vim'
" Plug 'senran101604/neotrix.vim'
" Plug 'wadackel/vim-dogrun'
