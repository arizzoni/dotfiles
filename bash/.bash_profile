#
# ~/.bash_profile
#

# Bash History
HISTCONTROL=ignoredups # Don't save duplicate commands
HISTSIZE=2000 # History size limit (in memory)
HISTFILESIZE=2000 # History size limit (on disk)

# Bash Completions
if [[ -f /usr/share/bash-completion/bash_completion ]]; then {
        source /usr/share/bash-completion/bash_completion
} fi

# Bash Shell Options
shopt -s autocd
shopt -s direxpand
shopt -s dotglob
shopt -s globstar
shopt -s histappend
shopt -s histreedit
shopt -s histverify
shopt -s hostcomplete
shopt -s interactive-comments
shopt -s no_empty_cmd_completion
shopt -s nocaseglob
shopt -s progcomp
shopt -s progcomp_alias
shopt -s promptvars
shopt -s sourcepath
set -o braceexpand
set -o noclobber



export QT_QPA_PLATFORMTHEME=qt5ct



# If the shell is interactive and .bashrc exists, get the aliases and functions
if [[ -f ~/.config/.bashrc ]]; then {
        source ~/.config/.bashrc
} fi
