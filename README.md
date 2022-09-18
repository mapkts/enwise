# enwise

A vim plugin that allows you to use `Enter` key to close unbalanced brackets.

![](https://raw.githubusercontent.com/mapkts/enwise/master/screenshot.gif)

I always feel a bit awkward when using auto-pairing plugins in Vim. The auto-generated closing brackets not only save no keystrokes (advancing past the closing brackets requires typing the same keys), but also cause a lot of distractions when coding. What `enwise` does is to only close brackets when you have pressed the `Enter` key, so you gain the advantages of auto-pairing and eyes-concentration. I've seen lots of advanced Vim users play Vim well without using any auto-pairing plugins, but as a Vim newbie I found bringing this plugin into my daily workflow really helpful.

## Installation

Install `enwise` with your favorite plugin manager, e.g [vim-plug]:

```vim
Plug 'mapkts/enwise'
```

or install manually by coping this repo to `~/.vim/pack/vendor/start/` (Vim 8+ only).

[vim-plug]: https://github.com/junegunn/vim-plug

## Features

- Free you mind from closing unbalanced brackets `{` `(` `[`.
- Respect your tab size and space size when inserting newline.
- Smart enough to escape brackets inside quoted string.
- Behave soundly when you press enter in the middle of a line.
- Brackets inside comments like `// {` `/* { */` are normally escaped.

## Examples

- Write a line of code from left to right ( `|` stands for cursor position )

before

```js
sort_by('hello', function (x) {|
```

after

```js
sort_by('hello', function (x) {
  |
})
```

- Brackets inside quoted string are automatically escaped

before

```rust
println!("brackets: {{([ {} {}"|
```

after

```rust
println!("brackets: {{([ {} {}"
    |
)
```

- Press enter inside non-eol brackets will push contents after the cursor down two lines

before

```js
sort_by('hello', function (x) {|})
```

after

```js
sort_by('hello', function (x) {
  |
})
```

- Brackets inside comments will also be escaped

before

```rust
// {([|
```

after

```rust
// {([
// |
```

before

```rust
/*
 * {([|
```

after

```rust
/*
 * {([
 * |
```

## Customization

- `enwise` only closes brackets for a list of supported languages ([see here]). In order to bypass this limitation, put `let g:enwise_enable_globally = 1` in your vimrc to enable it globally.

[see here]: https://github.com/mapkts/enwise/blob/master/plugin/enwise.vim

- By default this plugin takes control of the enter key if `<CR>` hasn't been mapped yet. If you want to overload the enter key, put `let g:enwise_disable_mappings = 1` in your vimrc before creating a conditional mapping. e.g.:

```vim
" Use <CR> to navigate completion menu (if pumvisible) or close brackets.
inoremap <silent><expr> <CR> pumvisible() ? "\<C-N>" : "\<CR>\<Plug>(EnwiseClose)"
```

- Calling `:EnwiseToggle` will toggle `enwise` on and off. You might want to temporarily disable this plugin when writing some syntax extension code (e.g. Rust macros). Note that you can create a mapping for this command like so:

```vim
nnoremap <leader>te :EnwiseToggle<CR>
```

## Bug Report

Currently the languages `Enwise` supported is limited. If you have encountered any bugs or inconvenience when using this plugin, please don't hesitate to open a issue.

## License

Licensed under the terms of the [MIT license](./LICENSE).
