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

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'nvim-treesitter/nvim-treesitter'
Plug 'romgrk/nvim-treesitter-context'

call plug#end()

colorscheme base16-google-dark

" set up completion
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<Tab>" :
            \ coc#refresh()

inoremap <silent><expr> <S-Tab>
            \ pumvisible() ? "\<C-p>" :
            \ <SID>check_back_space() ? "\<S-Tab>" :
            \ coc#refresh()

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
