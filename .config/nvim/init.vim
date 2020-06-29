" MY VIM CONFIGURATION
" Pluggins
if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ~/.config/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif
call plug#begin('~/.config/nvim/plugged')
" tpope shit, because is good
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-speeddating'
Plug 'mattn/emmet-vim'
Plug 'airblade/vim-gitgutter'

Plug 'janko/vim-test'
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/syntastic'
Plug 'Raimondi/delimitMate'
Plug 'editorconfig/editorconfig-vim'
Plug 'benmills/vimux'

Plug 'pbrisbin/vim-mkdir'

" Snippets
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'honza/vim-snippets'

Plug 'terryma/vim-multiple-cursors'

"PHP related
Plug 'StanAngeloff/php.vim'
Plug 'stephpy/vim-php-cs-fixer'
Plug 'adoy/vim-php-refactoring-toolbox'
Plug 'phpactor/phpactor', {'do': 'composer install', 'for': 'php'}
Plug 'vim-vdebug/vdebug'

Plug 'mileszs/ack.vim'

"This highlights and show previo of replaces
Plug 'markonm/traces.vim'

" Laravel
Plug 'tpope/vim-dispatch'             "| Optional
Plug 'tpope/vim-projectionist'        "|
" Plug 'roxma/nvim-completion-manager'  "|
Plug 'noahfrederick/vim-composer'     "|
Plug 'noahfrederick/vim-laravel'

" Documentation
Plug 'tobyS/vmustache'
Plug 'tobyS/pdv'
Plug 'SirVer/ultisnips'

" File handlers
Plug 'posva/vim-vue'
Plug 'jwalton512/vim-blade'
Plug 'kovetskiy/sxhkd-vim'

" Status Bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'nathanaelkane/vim-indent-guides'

" TagBar
Plug 'majutsushi/tagbar'

" Completition Server
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vimwiki/vimwiki'

Plug 'freitass/todo.txt-vim'

Plug 'mxw/vim-jsx'
Plug 'cespare/vim-toml'
Plug 'calviken/vim-gdscript3'

" Themes
Plug 'arcticicestudio/nord-vim'
Plug 'morhetz/gruvbox'

call plug#end()


syntax enable

let mapleader = ','

set undodir=~/.config/nvim/undodir
set undofile

" Editor
set number
set relativenumber
let g:gruvbox_italic=1
colorscheme gruvbox

hi phpKeyword cterm=italic ctermfg=167
hi htmlArg cterm=italic ctermfg=108
hi bladeKeyword cterm=italic ctermfg=167

let &colorcolumn="80,".join(range(120,999),",")

set tabstop=4
set shiftwidth=4
set expandtab

set clipboard=unnamedplus

" Search
set ignorecase
set hlsearch
set incsearch
nmap <Leader><space> :nohlsearch<cr>

" SPLITS and Moves
set splitbelow
set splitright

nmap <C-J> <C-W><C-J>
nmap <C-K> <C-W><C-K>
nmap <C-H> <C-W><C-H>
nmap <C-L> <C-W><C-L>

" The way to get out of the internal terminal
tnoremap <C-o> <C-\><C-n>


" Update binds when sxhkdrc is updated.
autocmd BufWritePost *sxhkdrc !pkill -USR1 sxhkd

" FZF
set rtp+=/usr/local/opt/fzf
nmap <C-P> :Files .<cr>
nmap <C-E> :Buffer <cr>
nmap <C-T> :BTags <cr>
let g:fzf_layout = { 'window': '15new' }

" PHP CS
let g:php_cs_fixer_config_file = '.php_cs'
nnoremap <silent><leader>pf :call PhpCsFixerFixFile()<cr>

"NERDTree
let NERDTreeHijackNetrw = 0
nmap <leader>1 :NERDTreeToggle<cr>
let NERDTreeWinPos = "right"

"Syntastic
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
let g:syntastic_ignore_files = ['\m\cTest.php$', 'Pest.php']

"pdv
let g:pdv_template_dir = $HOME ."/.config/nvim/bundle/pdv/templates_snip"
nnoremap <leader>d :call pdv#DocumentWithSnip()<CR>
nnoremap <leader>ds :call pdv#DocumentCurrentLine()()<CR>

"Tags
function! DelTagOfFile(file)
    let fullpath = a:file
    let cwd = getcwd()
    let tagfilename = cwd . "/tags"
    let f = substitute(fullpath, cwd . "/", "", "")
    let f = escape(f, './')
    let cmd = 'sed -i "/' . f . '/d" "' . tagfilename . '"'
    let resp = system(cmd)
endfunction

function! CreateTagFile()
    let cwd = getcwd()
    let tagfilename = cwd . "/tags"
    let cmd = 'rm '. tagfilename
    let resp = system(cmd)
    let cmd = 'ctags -R --exclude=node_modules --PHP-kinds=+cdfint-av --fileds=+aimls --tag-relative=yes --exlude=*Test.php --exclude=*phpunit* '
    let resp = system(cmd)
endfunction

function! UpdateTags()
    let f = expand("%:p")
    let cwd = getcwd()
    let tagfilename = cwd . "/tags"
    let cmd = 'ctags -a -f ' . tagfilename . ' --language=php --fields=+aimlS --php-kinds=+cdfint-av --tag-relative=yes --totals=yes ' . '"' . f . '"'
    call DelTagOfFile(f)
    let resp = system(cmd)
endfunction
autocmd BufWritePost *.php call UpdateTags()

autocmd FileType php inoremap <Leader>c <Esc>:PhpactorContextMenu<CR>
autocmd FileType php noremap <Leader>c :PhpactorContextMenu<CR>

"map the add use
autocmd FileType php inoremap <Leader>n <Esc>:PhpactorImportClass<CR>
autocmd FileType php noremap <Leader>n :PhpactorImportClass<CR>

"map the expand class
autocmd FileType php inoremap <Leader>nf <Esc>:PhpactorClassExpand<CR>
autocmd FileType php noremap <Leader>nf :PhpactorClassExpand<CR>

""order by A-Z
autocmd FileType php inoremap <Leader>sus <Esc>:PhpactorImportMissingClasses<CR>
autocmd FileType php noremap <Leader>sus :PhpactorImportMissingClasses<CR>

"order the import by the lenght
vmap <leader>su ! awk '{ print length(), $0 \| "sort -n \| cut -d\\  -f2-" }'<cr>

"Snippets
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" airline
let g:airline_powerline_fonts=0
let g:airline_theme='gruvbox'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
" set laststatus=1

" COC

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
"inoremap <silent><expr> <TAB>
"      \ pumvisible() ? "\<C-n>" :
"      \ <SID>check_back_space() ? "\<TAB>" :
"      \ coc#refresh()
"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" Testing snippets
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'
"Testing snipets coc

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" Editor Config
let g:EditorConfig_exclude_patterns = ['fugitive://.\*']


nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>

nmap <leader>q :call VimuxCloseRunner()<CR>

let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]


" Macros
" Macro to initialize variables
let @a="yiw/}O$this->pA = $pA;?constructOprotected $pA;/\"e, "

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

noremap <Leader>fi :call PhpImplementations('<cword>')<CR>
noremap <Leader>fe :call PhpSubclasses('<cword>')<CR>

" PHP Find Usage
function! PhpUsage(word)
    exe 'Ack "::' . a:word . '\(|>' . a:word . '\("'
endfunction

noremap <Leader>fu :call PhpUsage('<cword>')<CR>

noremap <C-q> :bd!<cr>

noremap <Leader>ff :execute('Ack <cword>')<CR>

let g:vim_php_refactoring_make_setter_fluent = 1

nmap <Leader>2 :TagbarToggle<CR>

let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
let g:indent_guides_guide_size=1
let g:indent_guides_start_level=2
hi IndentGuidesOdd  ctermbg=black
hi IndentGuidesEven ctermbg=darkgrey

" forward and backward search of current word
nnoremap * /\<<C-R>=expand('<cword>')<CR>\><CR>
nnoremap # ?\<<C-R>=expand('<cword>')<CR>\><CR>

nnoremap <leader>now :r !date +"\%Y-\%m-\%dT\%H:\%M:\%:z" <CR>

autocmd BufWritePre *s/\s\+%//e

autocmd BufWritePost *Xresources,*Xdefaults !xrdb %

nnoremap <leader>a :Rg<space>
nnoremap <leader>A :exec "Rg ".expand("<cword>")<CR>

autocmd VimEnter * command! -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)


let g:vdebug_options = {'break_on_open': 0}

" start debuygger with the key
function! StartPhpDebuging()
    exe "VimuxRunCommand('export XDEBUG_CONFIG=\"idekey=xdebug\"')"
    exe 'VdebugStart'
    let test#strategy="vimux"
endfunction
function! StopPhpDebuging()
    exe "VimuxCloseRunner"
    exe "python3 debugger.close()"
    exe "python3 debugger.close()"
    let test#strategy="neovim"
endfunction

noremap <Leader>t :call StartPhpDebuging()<CR>
noremap <Leader>T :call StopPhpDebuging()<CR>
