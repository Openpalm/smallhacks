

 ## Setting up NeoVim as IDE

 * install ctags or exuberant-ctag for searching and navigation

 * make sure ~/.ctags includes the following lines:
 ```sbt
 --langdef=scala
 --langmap=scala:.scala
 --regex-scala=/^[ \t]*((abstract|final|sealed|implicit|lazy)[ \t]*)*(private[^ ]*|protected)?[ \t]*class[ \t]+([a-zA-Z0-9_]+)/\4/c,classes/
 --regex-scala=/^[ \t]*((abstract|final|sealed|implicit|lazy)[ \t]*)*(private[^ ]*|protected)?[ \t]*object[ \t]+([a-zA-Z0-9_]+)/\4/c,objects/
 --regex-scala=/^[ \t]*((abstract|final|sealed|implicit|lazy)[ \t]*)*(private[^ ]*|protected)?[ \t]*((abstract|final|sealed|implicit|lazy)[ \t]*)*case class[ \t]+([a-zA-Z0-9_]+)/\6/c,case classes/
 --regex-scala=/^[ \t]*((abstract|final|sealed|implicit|lazy)[ \t]*)*(private[^ ]*|protected)?[ \t]*case object[ \t]+([a-zA-Z0-9_]+)/\4/c,case objects/
 --regex-scala=/^[ \t]*((abstract|final|sealed|implicit|lazy)[ \t]*)*(private[^ ]*|protected)?[ \t]*trait[ \t]+([a-zA-Z0-9_]+)/\4/t,traits/
 --regex-scala=/^[ \t]*type[ \t]+([a-zA-Z0-9_]+)/\1/T,types/
 --regex-scala=/^[ \t]*((abstract|final|sealed|implicit|lazy|private[^ ]*(\[[a-z]*\])*|protected)[ \t]*)*def[ \t]+([a-zA-Z0-9_]+)/\4/m,methods/
 --regex-scala=/^[ \t]*((abstract|final|sealed|implicit|lazy|private[^ ]*|protected)[ \t]*)*val[ \t]+([a-zA-Z0-9_]+)/\3/l,constants/
 --regex-scala=/^[ \t]*((abstract|final|sealed|implicit|lazy|private[^ ]*|protected)[ \t]*)*var[ \t]+([a-zA-Z0-9_]+)/\3/l,variables/
 --regex-scala=/^[ \t]*package[ \t]+([a-zA-Z0-9_.]+)/\1/p,packages/
 CTAGS=$(shell command-v ctags)
 ```

 * make sure the sbt plugin for tags is installed and and that ~/.sbt/0.13/plugins/plugins.sbt includes the following line:
 ` addSbtPlugin("net.ceedubs" %% "sbt-ctags" % "0.2.0")`

 * generate the ctags for the project inside the trunk directory
 `sbt gen-ctags`

 - get neoVim (vim is too slow)

 ```bash
 git clone https://github.com/neovim/neovim
 cd neovim
 make CMAKE_BUILD_TYPE=RelWithDebInfo
 sudo make install
 ```

 - customize neoVim as you wish, see included init.vim for tips

 - make sure these lines are included in the init.vim, ctags auto completion @ leonard.io/blog/2013/04/editing-scala-with-vim/

 ```vim
 set tags=./tags;,tags;/
 let g:scala_sort_across_groups=1
 set regexpengine=1
 nnoremap <C-T> <C-w>g] <C-r><C-w>
 ```
 the binding "ctrl t" will jump to the definition under the cursor (or offer a list to choose from)
 and open the file in a new horizontal tab.

 the binding "ctrl p" will find any files within the project. (assuming you're using the given init.vim)

 the binding "f9" will open a NerdTree fs commander for navigation
