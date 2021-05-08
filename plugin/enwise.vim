if !get(g:, "enwise_enable_global")
    let g:enwise_enable_global = 0
endif

augroup enwise
    autocmd!

    autocmd Filetype * if g:enwise_enable_global | let b:enwise = 1 | endif

    autocmd Filetype c,cpp,cs,rust,java,javascript,typescript,javascript.jsx,javascriptreact,typescriptreact,php
        \ let b:enwise = 1 |
        \ let b:enwise_bcomment_matcher = '^\*.*$' |
        \ let b:enwise_lcomment_matcher = '\(\/\/.*\|\/\*.*\*\/\)'

    " Unstable hack to strip Rust lifetime 'a, 'abc
    autocmd Filetype rust
        \ let b:enwise_lcomment_matcher =  '\(\/\/.*\|\/\*.*\*\/\|''[_a-zA-Z]\+\)'

    autocmd Filetype css
        \ let b:enwise = 1 |
        \ let b:enwise_bcomment_matcher = '^\*.*$' |
        \ let b:enwise_lcomment_matcher = '\/\*.*\*\/'

    autocmd Filetype python
        \ let b:enwise = 1 |
        \ let b:enwise_lcomment_matcher = '\#.*'

    autocmd Filetype go
        \ let b:enwise = 1 |
        \ let b:enwise_lcomment_matcher = '\/\/.*'

    autocmd Filetype vim
        \ let b:enwise = 1

    autocmd Filetype * call enwise#try_enable()
augroup END

inoremap <silent> <Plug>(EnwiseClose) <C-R>=enwise#close()<CR>
nnoremap <silent> <Plug>(EnwiseToggle) :<C-U>call enwise#toggle()<CR>

command! -nargs=0 EnwiseToggle :call enwise#toggle()
