if !get(g:, "enwise_enable_globally")
  let g:enwise_enable_globally = 0
endif

if !get(g:, "enwise_disable_mappings")
  let g:enwise_disable_mappings = 0
endif

if !get(g:, "enwise_auto_semicolon")
    let g:enwise_auto_semicolon = 0
endif

augroup enwise
  autocmd!

  autocmd Filetype c,cpp,cs,rust,java,javascript,typescript,javascript.jsx,javascriptreact,typescriptreact,php
        \ let b:enwise = 1 |
        \ let b:enwise_bc_matcher = '^\*.*$' |
        \ let b:enwise_lc_matcher = '\(\/\/.*\|\/\*.*\*\/\)'

  " Hack to strip Rust lifetime 'a, 'abc
  autocmd Filetype rust
        \ let b:enwise_lc_matcher =  '\(\/\/.*\|\/\*.*\*\/\|''[_a-zA-Z]\+\)'

  autocmd Filetype css
        \ let b:enwise = 1 |
        \ let b:enwise_bc_matcher = '^\*.*$' |
        \ let b:enwise_lc_matcher = '\/\*.*\*\/'

  autocmd Filetype python
        \ let b:enwise = 1 |
        \ let b:enwise_lc_matcher = '\#.*'

  autocmd Filetype go
        \ let b:enwise = 1 |
        \ let b:enwise_lc_matcher = '\/\/.*'

  autocmd Filetype vim
        \ let b:enwise = 1

  autocmd BufEnter * if g:enwise_enable_globally | let b:enwise = 1 | endif

  autocmd BufEnter * call enwise#try_enable()
augroup END

inoremap <silent> <Plug>(EnwiseClose) <C-R>=enwise#close()<CR>
nnoremap <silent> <Plug>(EnwiseToggle) :<C-U>call enwise#toggle()<CR>

command! -nargs=0 EnwiseToggle :call enwise#toggle()
