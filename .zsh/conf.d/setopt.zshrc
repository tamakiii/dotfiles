setopt auto_menu auto_cd correct auto_name_dirs auto_remove_slash
setopt pushd_ignore_dups rm_star_silent sun_keyboard_hack
setopt cdable_vars sh_word_split auto_param_keys
setopt auto_pushd
setopt list_packed
setopt nolistbeep
setopt complete_aliases
setopt share_history        # share command history data
setopt hist_ignore_all_dups hist_reduce_blanks hist_no_store print_eight_bit
setopt prompt_subst
stty stop undef

setopt auto_param_slash      # ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt mark_dirs             # ファイル名の展開でディレクトリにマッチした場合 末尾に / を付加
setopt list_types            # 補完候補一覧でファイルの種別を識別マーク表示 (訳注:ls -F の記号)
setopt auto_menu             # 補完キー連打で順に補完候補を自動で補完
setopt auto_param_keys       # カッコの対応などを自動的に補完
setopt interactive_comments  # コマンドラインでも # 以降をコメントと見なす
setopt magic_equal_subst     # コマンドラインの引数で --prefix=/usr などの = 以降でも補完できる

setopt complete_in_word      # 語の途中でもカーソル位置で補完
setopt always_last_prompt    # カーソル位置は保持したままファイル名一覧を順次その場で表示
