set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

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
