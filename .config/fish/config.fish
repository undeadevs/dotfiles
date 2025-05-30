if status is-interactive
    # Commands to run in interactive sessions can go here
end

# =============================================================================
#
# Utility functions for zoxide.
#

# pwd based on the value of _ZO_RESOLVE_SYMLINKS.
function __zoxide_pwd
    builtin pwd -L
end

# A copy of fish's internal cd function. This makes it possible to use
# `alias cd=z` without causing an infinite loop.
if ! builtin functions --query __zoxide_cd_internal
    if builtin functions --query cd
        builtin functions --copy cd __zoxide_cd_internal
    else
        alias __zoxide_cd_internal='builtin cd'
    end
end

# cd + custom logic based on the value of _ZO_ECHO.
function __zoxide_cd
    __zoxide_cd_internal $argv
end

# =============================================================================
#
# Hook configuration for zoxide.
#

# Initialize hook to add new entries to the database.
function __zoxide_hook --on-variable PWD
    test -z "$fish_private_mode"
    and command zoxide add -- (__zoxide_pwd)
end

# =============================================================================
#
# When using zoxide with --no-cmd, alias these internal functions as desired.
#

if test -z $__zoxide_z_prefix
    set __zoxide_z_prefix 'z!'
end
set __zoxide_z_prefix_regex ^(string escape --style=regex $__zoxide_z_prefix)

# Jump to a directory using only keywords.
function __zoxide_z
    set -l argc (count $argv)
    if test $argc -eq 0
        __zoxide_cd $HOME
    else if test "$argv" = -
        __zoxide_cd -
    else if test $argc -eq 1 -a -d $argv[1]
        __zoxide_cd $argv[1]
    else if set -l result (string replace --regex $__zoxide_z_prefix_regex '' $argv[-1]); and test -n $result
        __zoxide_cd $result
    else
        set -l result (command zoxide query --exclude (__zoxide_pwd) -- $argv)
        and __zoxide_cd $result
    end
end

# Completions.
function __zoxide_z_complete
    set -l tokens (commandline --current-process --tokenize)
    set -l curr_tokens (commandline --cut-at-cursor --current-process --tokenize)

    if test (count $tokens) -le 2 -a (count $curr_tokens) -eq 1
        # If there are < 2 arguments, use `cd` completions.
        complete --do-complete "'' "(commandline --cut-at-cursor --current-token) | string match --regex '.*/$'
    else if test (count $tokens) -eq (count $curr_tokens); and ! string match --quiet --regex $__zoxide_z_prefix_regex. $tokens[-1]
        # If the last argument is empty and the one before doesn't start with
        # $__zoxide_z_prefix, use interactive selection.
        set -l query $tokens[2..-1]
        set -l result (zoxide query --exclude (__zoxide_pwd) --interactive -- $query)
        and echo $__zoxide_z_prefix$result
        commandline --function repaint
    end
end
complete --command __zoxide_z --no-files --arguments '(__zoxide_z_complete)'

# Jump to a directory using interactive search.
function __zoxide_zi
    set -l result (command zoxide query --interactive -- $argv)
    and __zoxide_cd $result
end

# =============================================================================
#
# Commands for zoxide. Disable these using --no-cmd.
#

abbr --erase z &>/dev/null
alias z=__zoxide_z

abbr --erase zi &>/dev/null
alias zi=__zoxide_zi

# =============================================================================

function fuck -d "Correct your previous console command"
  set -l fucked_up_command $history[1]
  env TF_SHELL=fish TF_ALIAS=fuck PYTHONIOENCODING=utf-8 thefuck $fucked_up_command THEFUCK_ARGUMENT_PLACEHOLDER $argv | read -l unfucked_command
  if [ "$unfucked_command" != "" ]
    eval $unfucked_command
    builtin history delete --exact --case-sensitive -- $fucked_up_command
    builtin history merge
  end
end

function fish_greeting
    neofetch
end

function fish_mode_prompt
end

function fish_prompt
    printf "\n┌"
    set_color brblack
    printf "\UE0B6"
    set_color white
    set_color -b brblack
    printf "%s@%s " $USER $hostname
    set_color brblack
    set_color -b blue
    printf "\UE0B4 "
    set_color white
    set_color -b blue
    printf "%s " (basename $SHELL)
    set_color blue
    set_color -b cyan
    printf "\UE0B4"
    set_color normal
    set_color -b cyan
    printf " "
    set_color black
    printf "%s" (prompt_pwd)
    set_color normal
    set_color cyan
    printf "\UE0B4"
    set_color normal
    printf "\n└ "
    switch $fish_bind_mode
        case "default"
            set_color brblue
            printf "[N] "
            set_color normal
        case "insert"
            set_color brcyan
            printf "[I] "
            set_color normal
        case "visual"
            set_color bryellow
            printf "[V] "
            set_color normal
        case "replace"
            set_color brpurple
            printf "[R] "
            set_color normal
        case "replace-one"
            set_color brpurple
            printf "[R] "
            set_color normal
    end 
end

set -gx EDITOR nvim

# set -gx GTK_IM_MODULE wayland
set -gx QT_IM_MODULE fcitx
set -gx XMODIFIERS "@im=fcitx"

function brc
    z $(fd --base-directory ~/code -a --no-ignore --max-depth 3 --type d | fzf)
end

alias supacman="sudo pacman"
alias gitzip="git archive HEAD -o"

alias gdot="git --git-dir=$HOME/dotfiles/ --work-tree=$HOME"

# pnpm
set -gx PNPM_HOME "/home/undeadevs/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# nvm
set -Ux nvm_default_version "latest"

# Created by `pipx` on 2023-09-20 03:48:02
set PATH $PATH /home/undeadevs/.local/bin
