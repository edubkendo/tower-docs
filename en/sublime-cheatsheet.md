# Sublime Cheatsheet

cmd-p             Goto Anything ('@' for functions, ':' for line number)
cmd-r             Function finder
ctl-g             Goto line number
cmd-sft-p         Command palette
cmd-sft-f         Find in Files
cmd-opt-r         Toggle regex when finding
cmd-opt-#         Columns
ctr-#             Switch columns
ctr-sft-#         Move to column
cmd-ctr-r         Reveal in sidebar (requires keybinding)

Coding:

ctr-m             jump to matching bracket
cmd-sft-space     select scope (handy but conflicts with my Divvy)
ctr-sft-.         erb tag* (requires keybinding)
cmd-ctr-a         auto align*
cmd-sft-h         goto documentation*

Text:

cmd-alt-f         replace in file
cmd-l             select current line
cmd-sft-d         duplicate current line
cmd-sft-enter     insert line before (after w/o sft)
cmd-ctr-g         select all instances of selected word in file
cmd-d, repeat     mutli-select word, progressively
cmd-shift-up      move line up (also, down)
cmd-ctr-sft-f     distraction-free editing
cmd-k, cmd-i      create private gist*
cmd-j             join lines

* requires package

Ctrl+0 moves you to the sidebar, and then the arrow keys and enter work as expected.

https://github.com/titoBouzout/SideBarEnhancements
http://net.tutsplus.com/tutorials/python-tutorials/how-to-create-a-sublime-text-2-plugin/

Install by following the instructions here: https://github.com/kemayo/sublime-text-2-git/wiki (Easy way to install: use Package Control: Install Package and search for “Git”).

Use it. Shift + Command + P comes in use again. Shift + Command + P and write “git”, you will see all the possible git commands you most probably use on a day-to-day basis. Shift + Command + P+ “git blame” + hit that “Enter” + punch the colleague that broke the sacred code. :) You have it all - git status, git pull, git push, git diff, you name it.

[Ctags with Sublime Text and Coffeescript](https://gist.github.com/2901380)

Ctags are incredibly helpful for navigating within Tower itself, jumping quickly to functions and methods when you don't know where they originate.

[mocha-coffeescript-tmbundle](https://github.com/markbates/mocha-coffeescript-tmbundle)

Installs snippets and syntax support for mocha coffeescript files.

[SublimeREPL](https://github.com/wuub/SublimeREPL)

Use the coffeescript repl from within Sublime Text with full syntax highlighting and auto-completion. Actually, wondering how hard it would be to hack this to run the Tower console.


http://1p1e1.tumblr.com/post/14262857223/9-reasons-you-must-install-sublime-text-2-code-like-a

https://github.com/kemayo/sublime-text-2-clipboard-history
https://github.com/weslly/Nettuts-Fetch
https://github.com/Kronuz/SublimeCodeIntel

http://www.youtube.com/watch?v=iejQvQF-vZo