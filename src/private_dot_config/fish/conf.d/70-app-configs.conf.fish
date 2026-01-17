set -gx GTK2_RC_FILES (test -n "$XDG_CONFIG_HOME"; and echo $XDG_CONFIG_HOME; or echo $HOME/.config)/gtk-2.0/gtkrc
set -gx RUSTUP_HOME (test -n "$XDG_DATA_HOME"; and echo $XDG_DATA_HOME; or echo $HOME/.local/share)/rustup
set -gx CARGO_HOME (test -n "$XDG_CACHE_HOME"; and echo $XDG_CACHE_HOME; or echo $HOME/.cache)/cargo
set -gx MAMBA_ROOT_PREFIX (test -n "$XDG_DATA_HOME"; and echo $XDG_DATA_HOME; or echo $HOME/.local/share)/micromamba
set -gx NPM_CONFIG_USERCONFIG (test -n "$XDG_CONFIG_HOME"; and echo $XDG_CONFIG_HOME; or echo $HOME/.config)/npm/npmrc
