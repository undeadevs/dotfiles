#
# ~/.bash_profile
#

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx

[[ -f ~/.bashrc ]] && . ~/.bashrc
. "$HOME/.cargo/env"
