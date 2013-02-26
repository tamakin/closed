# Closed
rubyで初めて作ったツール。

店の定休日を記述したyamlを引数で渡すとその日が定休日の店を表示するだけのツールです。

ruby closed.rb -f test.yml -d 2013/02/17
----- 2013-02-17 closed -----
床屋
パン屋
郵便局

ruby closed.rb --help
Usage: closed [options]
    -f configfile
    -d [date]
