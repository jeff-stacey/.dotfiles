setxkbmap -option caps:ctrl_modifier
xmodmap $(dirname $(readlink -f $0))/Xmodmap

