# enwise

A vim plugin that allows you to use `Enter` key to close brackets.

![](https://raw.githubusercontent.com/mapkts/enwise/master/screenshot.gif)

# Installation

Add this to your `~/.vimrc` if you are using [`vim-plug`]:

```vim
Plug 'mapkts/enwise'
```

or install manually by coping this repo to `~/.vim/plugin`.

[vim-plug]: https://github.com/junegunn/vim-plug

## Features

- Free you mind from closing unbalanced brackets `{` `(` `[`.
- Respect your tab size and space size when inserting newline.
- Smart enough to escape brackets inside quoted string.
- Behave soundly when you press enter before some trailing characters in cursorline.
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

- Press enter at non-eol position will push contents after cursor down the line

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

- `enwise` only closes brackets for a list of supported languages ([see-here]). In order to bypass this limitation, put `let g:enwise_enable_global = 1` in your vimrc to enable it globally.

[see-here]: https://github.com/mapkts/vim-encloser/blob/master/plugin/encloser.vim

- Calling `:EnwiseToggle` will toggle `enwise` on and off. You might want to temporarily disable this plugin when writing some syntax extension code, like Rust macros. 

Note that you can create a mapping for this command like so:

```vim
nnoremap <leader>te :EnwiseToggle<CR>
```

## License

Licensed under the terms of the [MIT license](./LICENSE).
