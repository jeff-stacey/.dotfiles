set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
 
"C-w does window moves in terminal mode
tnoremap <C-w> <C-\><C-n><C-w>

"Don't print line numbers in terminal
autocmd TermOpen * setlocal nonumber norelativenumber

"set up vim plug
call plug#begin('~/.vim/plugged')

Plug 'chriskempson/base16-vim'

Plug 'tpope/vim-fugitive'

Plug 'machakann/vim-highlightedyank'

Plug 'neovim/nvim-lspconfig'

Plug 'neoclide/coc.nvim', {'commit': '1d3c525e2d6af0c07ed19fa7a5016ffc6a9e8421'}

Plug 'nvim-treesitter/nvim-treesitter'
Plug 'romgrk/nvim-treesitter-context'

call plug#end()

colorscheme base16-google-dark

"" set up completion
"function! s:check_back_space() abort
"    let col = col('.') - 1
"    return !col || getline('.')[col - 1] =~ '\s'
"endfunction
"
"inoremap <silent><expr> <Tab>
"            \ pumvisible() ? "\<C-n>" :
"            \ <SID>check_back_space() ? "\<Tab>" :
"            \ coc#refresh()
"
"inoremap <silent><expr> <S-Tab>
"            \ pumvisible() ? "\<C-p>" :
"            \ <SID>check_back_space() ? "\<S-Tab>" :
"            \ coc#refresh()

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()

inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

lua << EOF
require('lspconfig')['clangd'].setup{}
require('lspconfig')['jedi_language_server'].setup{}
EOF

" set up treesitter-context
noremap <silent><C-C> :TSContextToggle<CR>

lua << EOF
require'treesitter-context'.setup{
    enable = false,
    throttle = true,
    max_lines = 0,
    patterns = {
        python = {
                'class',
                'def',
                'if',
                'elif',
                'else',
                'for',
                'while',
                'try',
                'finally',
                'with',
        }
    }
}
EOF
