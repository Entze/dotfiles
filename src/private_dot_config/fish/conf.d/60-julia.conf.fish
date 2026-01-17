set -gx JULIA_DEPOT_PATH (test -n "$XDG_DATA_HOME"; and echo $XDG_DATA_HOME; or echo $HOME/.local/share)/julia
