# Vim Cheatsheet

Unknowns:

- block selection
- aligning = and :
- switching between languages
- vertically select block of text

- http://docs.sublimetext.info/en/latest/index.html
- https://github.com/phillipkoebbe/DetectSyntax

Use the > command. To indent 5 lines, 5>>. To mark a block of lines and indent it, Vjj> to indent 3 lines (vim only). To indent a curly-braces block, put your cursor on one of the curly braces and use >%.

If you’re copying blocks of text around and need to align the indent of a block in its new location, use ]p instead of just p. This aligns the pasted block with the surrounding text.

Also, the shiftwidth setting allows you to control how many spaces to indent.

>>   Indent line by shiftwidth spaces
<<   De-indent line by shiftwidth spaces
5>>  Indent 5 lines
5==  Re-indent 5 lines

var a = b;
var asdf = j;

>%   Increase indent of a braced or bracketed block (place cursor on brace first)
=%   Reindent a braced or bracketed block (cursor on brace)
<%   Decrease indent of a braced or bracketed block (cursor on brace)
]p   Paste text, aligning indentation with surroundings

=i{  Re-indent the 'inner block', i.e. the contents of the block
=a{  Re-indent 'a block', i.e. block and containing braces
=2a{ Re-indent '2 blocks', i.e. this block and containing block

>i{  Increase inner block indent
<i{  Decrease inner block indent

## Vim Commands

```
:scriptnames
:colorscheme github
```

## MC

```
brew install mc
```

http://eureka.ykyuen.info/2011/04/04/nerdtree-the-file-explorer-in-vivim/
http://www.vim.org/scripts/script.php?script_id=2438

## Vim Syntax Highlighting

Add this to `~/.vimrc`:

```
set term=ansi
syntax on
set number
foldmethod=syntax
```

Also make sure that "Display ANSI colors" is enabled in the Terminal Settings.

http://amix.dk/vim/vimrc.html

To use the variable in this expression, you need to use the execute command:

execute ':set gfn=Monaco:h' . a:n 

You have to use `gvim` (MacVim), a separate app, to control font faces and sizes.

- delete previous word: `db`