" Install Vimplug if not installed
set exrc
if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
    echo "Downloading junegunn/vim-plug to manage plugins..."
    silent !mkdir -p ~/.config/nvim/autoload/
    silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
    autocmd VimEnter * PlugInstall
endif

" Set plugin folder
call plug#begin('~/.config/nvim/plugged')

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'

Plug 'norcalli/snippets.nvim'

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" General use plugins
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-obsession'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-vinegar'

Plug 'vimwiki/vimwiki'

" File handling
Plug 'jwalton512/vim-blade'

" Laravel specific
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-projectionist'
Plug 'noahfrederick/vim-composer'
Plug 'noahfrederick/vim-laravel'

" Testing
Plug 'vim-test/vim-test'

" Error checking
Plug 'scrooloose/syntastic'

" Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/telescope.nvim'
Plug 'kyazdani42/nvim-web-devicons'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

"Searching using ack
Plug 'mileszs/ack.vim'

" Theme
Plug 'dracula/vim',{'as':'dracula'}

call plug#end()

syntax enable
set termguicolors

let mapleader = ' '

set undodir=~/.config/nvim/undodir
set undofile

set number
set relativenumber
colorscheme dracula
let g:airline_theme='dracula'

set tabstop=4
set shiftwidth=4
set expandtab
set updatetime=50
set cmdheight=2
set smartindent
set guicursor=
set nohlsearch
set hidden
set noerrorbells
set noswapfile
set nobackup
set incsearch
set noshowmode
set clipboard+=unnamedplus
set completeopt=menuone,noinsert,noselect

set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=#44475a

set ignorecase
set hlsearch
set incsearch
nmap <leader><space> :nohlsearch<cr>

set splitbelow
set splitright

if executable('rg')
    let g:rg_derive_root='true'
endif

let loaded_matchparen = 1

let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
let $FZF_DEFAULT_OPTS='--reverse'

let g:netrw_browse_split = 0
let g:netrw_banner = 0
let g:netrw_winsize = 25
let g:netrw_localrmdir='rm -r'

inoremap <C-c> <esc>
nnoremap <leader>pf :lua require('telescope.builtin').git_files()<CR>
nnoremap <leader>pa :lua require('telescope.builtin').live_grep()<CR>
nnoremap <leader>vr :lua require('telescope.builtin').lsp_references()<CR>
nnoremap <C-p> :Files<CR>
nnoremap <Leader>pt :Tags<CR>
nnoremap <Leader>tt :BTags<CR>
nnoremap <C-e> :Buffers<CR>
nnoremap <Leader><CR> :so ~/.config/nvim/init.vim<CR>
nnoremap <leader>vsh :lua vim.lsp.buf.signature_help()<CR>
nnoremap <leader>vd :lua vim.lsp.buf.definition()<CR>
nnoremap <leader>vh :lua vim.lsp.buf.hover()<CR>

nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>q :wincmd q<CR>

let g:completion_enable_snippet = 'snippets.nvim'

" LSP
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
lua require'nvim_lsp'.intelephense.setup{on_attach=require'completion'.on_attach}
lua require'nvim_lsp'.sumneko_lua.setup{on_attach=require'completion'.on_attach}
set iskeyword=@,48-57,_,192-255,$

au Filetype php setl omnifunc=v:lua.vim.lsp.omnifunc

" telescope
let g:telescope_cache_results = 1
let g:telescope_prime_fuzzy_find  = 1

autocmd BufWritePost *sxhkdrc !pkill -USR1 sxhkd

let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

let g:gitgutter_map_keys = 0


" forward and backward search of current word
nnoremap * /\<<C-R>=expand('<cword>')<CR>\><CR>
nnoremap # ?\<<C-R>=expand('<cword>')<CR>\><CR>


if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif

" Automatically open & close quickfix window
autocmd QuickFixCmdPost [^l]* nested cwindow

" PHP Find Implementations
function! PhpImplementations(word)
    exe 'Ack "implements.*' . a:word . ' *($|{)"'
endfunction

" PHP Find Subclasses
function! PhpSubclasses(word)
    exe 'Ack "extends.*' . a:word . ' *($|{)"'
endfunction

" PHP Find Usage
function! PhpUsage(word)
    exe 'Ack "::' . a:word . '\(|>' . a:word . '\("'
endfunction

noremap <Leader>fi :call PhpImplementations('<cword>')<CR>
noremap <Leader>fe :call PhpSubclasses('<cword>')<CR>
noremap <Leader>fu :call PhpUsage('<cword>')<CR>
noremap <Leader>ff :execute('Ack <cword>')<CR>

nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)

nmap ghs <Plug>(GitGutterStageHunk)
nmap ghu <Plug>(GitGutterUndoHunk)

luafile ~/.config/nvim/mysnippets.lua

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_loc_list_height = 2
let g:syntastic_php_phpcs_args = '--standard=PSR12'
let g:syntastic_php_checkers = ["php", "phpcs"]
let g:syntastic_ignore_files = ['\m\cTest.php$', 'Pest.php', 'vendor/', 'database/', 'nova/']

" Remap to not lose copy test on paste on visual mode
vnoremap <leader>p  "_dP

" Testing keymapping
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>

set secure
