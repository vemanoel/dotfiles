test -z "$PROFILEREAD" && . /etc/profile || true

export EDITOR=/usr/bin/hx

export MOZ_ENABLE_WAYLAND=1
export GDK_BACKEND=wayland

export GTK_IM_MODULE=cedilla
export QT_IM_MODULE=cedilla
