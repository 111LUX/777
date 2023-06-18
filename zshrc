### ### ### ### ### ### ### Systemwide zsh configuration

#PATH="/bin:/sbin:/usr/bin:/usr/sbin:/usr/games:/usr/local/bin:$HOME/.local/bin"
#LANGUAGE='en_US.utf8'
#LANG=$LANGUAGE

# start tmux with shell if it's installed, not running and user is not root
#(( $+commands[tmux] )) &&  [[ $UID -ne 0 && ! $TMUX ]] && exec tmux -2
export PAGER=less LESS='-gicAQR'
export EDITOR=vim
export LS_COLORS='di=1;32:ln=1;35:so=1;33:pi=1;31:ex=1;34:bd=1;34;40:cd=1;35;40:su=30;42:sg=37;42:tw=30;46:ow=31;46'
#export LSCOLORS=CxFxDxBxExEaFaachcagbg CLICOLOR=1

# auto logout after 1h of inactivity
TMOUT=3600
# number of jobs (if exist), current dir red/green color for user/root ($/#)
PROMPT="%(1j.%j.) %B%F{%(!.red.green)}%C%f %b%(!.#.$) "
SPROMPT='CORRECT> %R to %B%r%b (y|n|e|a)? '
HISTSIZE=100000
SAVEHIST=$HISTSIZE
HISTFILE=$HOME/.zhistory
KEYTIMEOUT=1
LISTMAX=999

setopt notify			# report the status of background jobs immediately
setopt correct			# try to correct the spelling of commands
setopt auto_cd			# if the command is the name of a directory, perform cd
setopt auto_list		# automatically list choices on an ambiguous completion
setopt auto_continue		# unsuspend suspended jobs on "disown" command
setopt chase_links		# resolve symlink to its real value when cd into it
setopt complete_in_word		# enable in word completion
setopt hash_cmds		# invocations of same command will use the saved location
setopt hash_dirs		# whenever a command name is hashed, hash the directory containing it
setopt append_history		# append history to the history file, rather than replace it
setopt inc_append_history	# history events are added to the $HISTFILE as soon as they are entered
setopt extended_history		# save command beginning timestamp and the duration
setopt hist_reduce_blanks	# remove superfluous blanks from history
setopt hist_ignore_dups		# do not save history line if it duplicates previous history event
setopt hist_ignore_all_dups	# if new command duplicates an older one, remove the older from history
setopt hist_expire_dups_first	# when delete duplicates in history, delete oldest history event
setopt hist_save_no_dups	# when writing history, older commands that duplicate newer ones are omitted
setopt hist_ignore_space	# do not save line to the history list when first character is a space
setopt hist_verify		# perform history expansion and reload the line into the editing buffer
setopt rec_exact		# recognize exact matches even if they are ambiguous
setopt auto_pushd		# cd push the old directory onto the directory stack
setopt pushd_ignore_dups	# don't push multiple copies of the same directory onto the directory stack
setopt pushd_silent		# do not print the directory stack after pushd or popd
setopt check_jobs		# report the status of jobs before exiting
setopt long_list_jobs		# list jobs in long format by default
setopt transient_rprompt	# hide right prompt from output
setopt glob_complete		# do not insert all the words resulting from the wildcard expansion
setopt extended_glob		# treat the "#", "~" and "^" characters as part of patterns
unsetopt nomatch		# do not show an error when using glob without quotes
unsetopt bad_pattern		# disable "bad pattern" error
unsetopt hup			# do not kill running jobs when shell exits
unsetopt auto_remove_slash	# disable automatic removing of slash
unsetopt check_running_jobs	# complain only about suspended jobs on exit
unsetopt bg_nice		# no lower prio for background jobs
unsetopt beep			# disable beep
unsetopt flow_control		# disable flow control via start/stop characters (^S/^Q)
[[ $UID -eq 0 ]] && setopt dot_glob # when logged in as root, completion uses dotfiles

autoload -Uz compinit; compinit
autoload -U select-word-style; select-word-style b
zstyle ':completion:*' verbose true
zstyle ':completion:*' use-cache true
zstyle ':completion:*' cache-path ~/.zsh/
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' accept-exact-dirs true
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' file-sort links
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
zstyle ':completion:*' completer _expand _prefix _complete _files _expand_alias _approximate _correct _command_names
zstyle ':completion:*:approximate:::' max-errors 3 numeric
zstyle ':completion:*:correct:::' max-errors 3 numeric
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*:commands' rehash true
zstyle ':completion:*:expand:*' keep-prefix true
zstyle ':completion:*:functions' ignored-patterns '_*'
# custom WORDCHARS for word navigation and kill-word/backward-kill-word
zstyle ':zle:*' word-chars '*?-[]~'
zstyle ':zle:*kill-word' word-chars '+*?-.[]~\_'

# select emacs keymap
bindkey -e
# up/down
bindkey '\e[A' history-beginning-search-backward
bindkey '\e[B' history-beginning-search-forward
bindkey '\eOA' history-beginning-search-backward
bindkey '\eOB' history-beginning-search-forward
# backspace key
bindkey "^?" backward-delete-char
# delete key
bindkey '\e[3~' delete-char
# alt+backspace
bindkey '\e\C?' vi-backward-kill-word
# alt+delete
bindkey '\e[3;3~' kill-word
# alt+z/shift+alt+z
bindkey '\ez' undo
bindkey '\eZ' redo
bindkey '\eя' undo
bindkey '\eЯ' redo
# alt+left/right
bindkey '\e[1;3D' backward-kill-word
bindkey '\e[1;3C' kill-word
# alt+up/down
bindkey '\e[1;3A' backward-kill-line
bindkey '\e[1;3B' kill-line
# ctrl+left/right
bindkey '\e[1;5D' backward-word
bindkey '\e[1;5C' forward-word
# ctrl+alt+left/right
bindkey '\e[1;7D' emacs-backward-word
bindkey '\e[1;7C' emacs-forward-word
# ctrl+up/down
bindkey '\e[1;5A' beginning-of-line
bindkey '\e[1;5B' end-of-line
# ctrl+alt+up/down
bindkey '\e[1;7A' history-incremental-search-backward
bindkey '\e[1;7B' history-incremental-search-forward
# end/home keys
bindkey '\e[1~' beginning-of-line 
bindkey '\e[4~' end-of-line
bindkey '\e[H' beginning-of-line
bindkey '\e[F' end-of-line
bindkey '\eOH' beginning-of-line
bindkey '\eOF' end-of-line
# ctrl+t/alt+t
bindkey "\CT" transpose-chars
bindkey "\et" transpose-words
# ctrl+p
bindkey '\CP' expand-cmd-path
# pageup/pagedown
bindkey '\e[5~' vi-up-line-or-history
bindkey '\e[6~' vi-down-line-or-history
# shift+tab
bindkey '\e[Z' reverse-menu-complete
# disable alt+x
bindkey -r '\ex'

# list dir with TAB, when there are only spaces/no text
# before cursor, or complete text, that is before cursor only
_autolist() { if [[ ${LBUFFER// } ]]
	then zle expand-or-complete-prefix
	else BUFFER=ls\ \"  CURSOR=4 zle list-choices
	zle end-of-list; fi }
zle -N _autolist; bindkey '\CI' _autolist

# crl+q - print listed completion suggestions above prompt
_endoflist() { zle end-of-list }
zle -N _endoflist; bindkey '\CQ' _endoflist

# ctr+del/ctrl+backspace - delete character from beginning/end of line
_del_first_char() { CURSOR=0 zle delete-char }
zle -N _del_first_char; bindkey '\e[3;5~' _del_first_char
_del_last_char() { CURSOR=9999 zle backward-delete-char }
zle -N _del_last_char; bindkey '\CH' _del_last_char

# ctrl+f - resume job 
_foreground() { CURSOR=0 LBUFFER+=' fg %'
	zle accept-line }
zle -N _foreground; bindkey '\CF' _foreground

# ctrl+r - update shell history
_read_hist() { fc -R
zle -M "history updated: `wc -l < $HISTFILE` events" }
zle -N _read_hist; bindkey '\CR' _read_hist

# alt+j - list jobs if exist
_list_jobs() { zle -M "`jobs -l`"}
zle -N _list_jobs; bindkey '\ej' _list_jobs

# alt+h - go to home/return to prev dir
_go_home() { [[ $PWD != $HOME ]] && \
	cd $HOME || pushd +1 2>/dev/null && \
	zle reset-prompt && zle -M "pwd: $PWD"
	[[ ${DISPLAY+X} ]] && precmd }
zle -N _go_home; bindkey '\eh' _go_home

# ctrl+b - return to previous dir
_back() { pushd +1 2>/dev/null && \
	zle reset-prompt; zle -M "dirs: `dirs -l`"
	[[ ${DISPLAY+X} ]] && precmd }
zle -N _back; bindkey '\CB' _back

# ctrl+u - go to upper dir
_go_up() { cd ..; zle reset-prompt; zle -M "pwd: $PWD"
	[[ ${DISPLAY+X} ]] && precmd }
zle -N _go_up; bindkey '\CU' _go_up

# X related functions (xclip required)
if [[ ${DISPLAY+X} ]]; then
# update terminal title: show current dir
precmd() { print -n "\e]0;$PWD\a" }
# shift+alt+c - add current line to X CLIPBOARD
_xclipcopyline() {
	if [[ ${BUFFER// } ]]
	then print -rn -- $BUFFER | xclip -sel c
	zle -M "\"$BUFFER\" saved to X CLIPBOARD"; fi }
zle -N _xclipcopyline; bindkey '\eC' _xclipcopyline
# ctrl+v - paste from PRIMARY selection if it's not  empty
_xclippaste() { xclip -o &> /dev/null && LBUFFER+="`xclip -o`" }
zle -N _xclippaste; bindkey '\CV' _xclippaste
# Launch in specific locale and supress output
R() { LC_ALL=ru_RU.UTF-8 $@ &> /dev/null &! }
fi

# aliases
alias -g '@'='| grep -i'
alias -g '@@'='| grep'
alias -g '##'='| wc -l'
alias -g '%%'='| xclip -sel c'
alias .='pwd'
alias c='cat'
alias f='find'
alias d='diff --color'
alias t='touch'
alias s='sudo'
alias k='pkill'
alias r='readlink -f'
alias history='fc -l -E 1'
alias l="$PAGER"
alias ls='ls -F'
alias la='ls -a'
alias ll='ls -lhS'
alias grep='grep --color'
alias g='grep -i'
alias v='vim'
alias e='builtin echo'
alias du='du -h'
alias ps='ps -Ao pid,%mem,user,start,command'
alias mkdir='mkdir -p'

