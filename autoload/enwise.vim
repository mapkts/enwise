" enwise.vim - Press enter to close unbalanced brackets in cursorline
" Maintainer: @mapkts
" Version: 0.1.0
" Repository: github.com/mapkts/enwise

if exists("g:enwise_loaded") | finish | endif
let g:enwise_loaded = 1
let g:enwise_default_escapes = ['''', '"']
let g:enwise_default_escape_leaders = ['\']

function! enwise#try_enable()
    let mapped = maparg('<CR>', 'i')
    if mapped ==# '' && get(b:, 'enwise') ==# 1
        imap <CR> <CR><Plug>(EnwiseClose)
    endif
endf

function! enwise#toggle()
    if get(b:, 'enwise') == 0
        let b:enwise = 1 
        imap <silent> <CR> <CR><Plug>(EnwiseClose)
        echo "Enwise enabled"
    else
        let b:enwise = 0 
        imap <silent> <CR> <CR>
        echo "Enwise disabled"
    endif
endf

function! enwise#close()
    " if enwise is not enabled, just return
    if !get(b:, 'enwise') | return '' | endif

    " if current position is not at EOL, just return a newline
    if match(getline('.'), '^\s*$') == -1 | return "\<ESC>==O" | endif

    let line = getline(line('.') - 1)
    let missing_brackets = s:get_missing_brackets(line)
    if empty(missing_brackets)
        return ''
    else
        return missing_brackets."\<ESC>==O"
    endif
endf

function! s:get_missing_brackets(line)
    let line = s:strip_comments(a:line)
    let chars = split(line, '\zs')

    let escapes = get(b:, 'enwise_escapes', g:enwise_default_escapes)
    let escape_leaders = get(b:, 'enwise_escape_leaders', g:enwise_default_escape_leaders)    
    
    let skip = 0
    let skip_char = ''
    let idx = -1
    let stack = []
    for ch in chars
        let idx += 1
        if !skip
            if index(escapes, ch) >= 0
                let skip = 1
                let skip_char = ch
            elseif ch ==# '{'
                call add(stack, '}')
            elseif ch ==# '('
                call add(stack, ')')
            elseif ch ==# '['
                call add(stack, ']')
            elseif !empty(stack) && stack[-1] ==# ch
                call remove(stack, -1)
            endif
        elseif index(escapes, ch) >= 0 && ch ==# skip_char
            if index(escape_leaders, get(chars, idx - 1, '')) ==# -1
                let skip = 0
            endif
        endif
    endfor

    return join(reverse(stack), '')
endf

function! s:strip_comments(text)
    let text = a:text
    
    " strip multi-line comments if b:enwise_bcomment_matcher was set
    let matcher = get(b:, 'enwise_bcomment_matcher')
    if !empty(matcher)
        let text = s:strip_multiline_comments(text)
    endif
    
    " strip single-line comments if b:enwise_lcomment_matcher was set
    let matcher = get(b:, 'enwise_lcomment_matcher')
    if !empty(matcher)
        let text = substitute(text, matcher, '', 'g')
    endif

    return text
endf

function! s:strip_multiline_comments(text)
    let line_above = getline(line('.') - 1)

    if match(trim(a:text), '^\*.*$') ==# 0 && match(trim(line_above), '^\/\?\*.*$') ==# 0
        return ''
    endif

    return a:text
endf
