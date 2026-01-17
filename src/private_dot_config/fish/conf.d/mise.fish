# Enable mise (see https://mise.jdx.dev/) if it is available
if command -v mise &>/dev/null
    mise activate fish | source
end
