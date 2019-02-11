# alias 
alias ls="ls --color=auto"
alias l=ls
alias la="ls -al"
alias lat="ls -at"
alias p=pwd
alias v=vim
alias e=emacs
alias mozc-config="/usr/lib/mozc/mozc_tool --mode=config_dialog"
alias mozc-dict="/usr/lib/mozc/mozc_tool --mode=dictionary_tool"
alias ≡╹ω╹≡="~/Sync/dotfiles/mofu.zsh"

# 文字コード
export LANG=ja_JP.UTF-8

# 色を使用出来るようにする  
autoload -Uz colors  
colors  

# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# 履歴の検索
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# git
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f "
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }

# プロンプト
setopt prompt_subst
PROMPT="%{${fg[red]}%}$ %{${reset_color}%}"
RPROMPT='${vcs_info_msg_0_}'"%{${fg[yellow]}%}[%~] %{${fg[cyan]}%}(%*)%{${reset_color}%} %{$fg[black]%(?.$bg[green].$bg[red])%}<%?>%{${reset_color}%}"

# Emacs ライクな操作
bindkey -e

# deleteキーなど
bindkey "^[OH" beginning-of-line
bindkey "^[OF" end-of-line
bindkey "^[[3~" delete-char

# Ctrl-Yで上のディレクトリに移動できる
function cd-up {
   zle push-line && LBUFFER='builtin cd ..' && zle accept-line
}
zle -N cd-up
bindkey "^Y" cd-up

# Ctrl-Dでシェルからログアウトしない
setopt ignoreeof

# Ctrl-Wでパスの文字列などをスラッシュ単位でdeleteできる
autoload -U select-word-style
select-word-style bash

# Ctrl-[で直前コマンドの単語を挿入できる
autoload -Uz smart-insert-last-word
zstyle :insert-last-word match '*([[:alpha:]/\\]?|?[[:alpha:]/\\])*' # [a-zA-Z], /, \ のうち少なくとも1文字を含む長さ2以上の単語
zle -N insert-last-word smart-insert-last-word
bindkey '^[' insert-last-word

# 自動補完
autoload -U compinit
compinit
zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'

# もしかして
setopt correct

# 入力したコマンドが存在せず、かつディレクトリ名と一致するなら、ディレクトリに cd する
setopt auto_cd
alias ...='cd ../..'
alias ....='cd ../../..'

# cd した先のディレクトリをディレクトリスタックに追加する
setopt auto_pushd

# pushd したとき、ディレクトリがすでにスタックに含まれていればスタックに追加しない
setopt pushd_ignore_dups

# 拡張 glob を有効にする
setopt extended_glob

# 入力したコマンドがすでにコマンド履歴に含まれる場合、履歴から古いほうのコマンドを削除する
setopt hist_ignore_all_dups

# コマンドがスペースで始まる場合、コマンド履歴に追加しない
setopt hist_ignore_space

# <Tab> でパス名の補完候補を表示したあと、続けて <Tab> を押すと候補からパス名を選択できるようになる
zstyle ':completion:*:default' menu select=1

# 単語の一部として扱われる文字のセットを指定する
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
