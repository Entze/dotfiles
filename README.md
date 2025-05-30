# Entze's Dotfiles

A dotfile repository, managed by [chezmoi](https://chezmoi.io).

## Installation

For every supported operating system includes, under `bootstrap/` in this
repository, a self-contained script to bootstrap the dotfiles. Specifically, it
will install [mise](#mise), [chezmoi](#chezmoi), and [git](#git).

Use the following command to initialize, and apply the configuration.

```bash
export GITHUB_USER="Entze"
export PATH="$HOME/.local/share/mise/installs/chezmoi/latest/:$PATH"
chezmoi init -- "$GITHUB_USER"
chezmoi apply
```

## Tools

A list of tools that are used, and their packaged versions for the supported
operating systems.

### bash

Bash serves as a fallback to [fish](#fish). Bash as interactive shell is
primarily useful in situations where POSIX compliance is mandatory.

[![latest packaged version(s)](https://repology.org/badge/latest-versions/bash.svg)](https://repology.org/project/bash/versions)\
[![Debian 13 package](https://repology.org/badge/version-for-repo/debian_13/bash.svg)](https://repology.org/project/bash/versions)

### bat-cat

Bat serves as a pager and commandline file viewer.

[![latest packaged version(s)](https://repology.org/badge/latest-versions/bat-cat.svg)](https://repology.org/project/bat-cat/versions)\
[![Debian 13 package](https://repology.org/badge/version-for-repo/debian_13/bat-cat.svg)](https://repology.org/project/bat-cat/versions)\
[![GitHub Release](https://img.shields.io/github/v/release/sharkdp/bat?display_name=release&label=mise&color=brightgreen)](https://github.com/sharkdp/bat/releases)

### chezmoi

Chezmoi serves as a declarative config manager.

[![latest packaged version(s)](https://repology.org/badge/latest-versions/chezmoi.svg)](https://repology.org/project/chezmoi/versions)\
[![Debian 13 package](https://repology.org/badge/version-for-repo/debian_13/chezmoi.svg)](https://repology.org/project/chezmoi/versions)\
[![GitHub Release](https://img.shields.io/github/v/release/twpayne/chezmoi?display_name=release&label=mise&color=brightgreen)](https://github.com/twpayne/chezmoi/releases)

### dateutils

Dateutils serves as a tool to work with dates.

[![latest packaged version(s)](https://repology.org/badge/latest-versions/dateutils.svg)](https://repology.org/project/dateutils/versions)\
[![Debian 13 package](https://repology.org/badge/version-for-repo/debian_13/dateutils.svg)](https://repology.org/project/dateutils/versions)

### deb-get

Deb-get serves as a 3rd party Debian repository manager and installation tool.

[![latest packaged version(s)](https://repology.org/badge/latest-versions/deb-get.svg)](https://repology.org/project/deb-get/versions)\
[![Debian 13 package](https://repology.org/badge/version-for-repo/debian_13/deb-get.svg)](https://repology.org/project/deb-get/versions)\
[![GitHub Release](https://img.shields.io/github/v/release/wimpysworld/deb-get?display_name=release&label=bootstrap&color=brightgreen)](https://github.com/wimpysworld/deb-get/releases)

### difftastic

Difftastic serves as a general purpose diff tool.

[![latest packaged version(s)](https://repology.org/badge/latest-versions/difftastic.svg)](https://repology.org/project/difftastic/versions)\
[![Debian 13 package](https://repology.org/badge/version-for-repo/debian_13/difftastic.svg)](https://repology.org/project/difftastic/versions)\
[![GitHub Release](https://img.shields.io/github/v/release/Wilfred/difftastic?display_name=release&label=mise&color=brightgreen)](https://github.com/Wilfred/difftastic/releases)

### du-dust

Dust serves as a file space estimation tool.

[![latest packaged version(s)](https://repology.org/badge/latest-versions/du-dust.svg)](https://repology.org/project/du-dust/versions)\
[![Debian 13 package](https://repology.org/badge/version-for-repo/debian_13/du-dust.svg)](https://repology.org/project/du-dust/versions)\
[![GitHub Release](https://img.shields.io/github/v/release/bootandy/dust?display_name=release&label=mise&color=brightgreen)](https://github.com/bootandy/dust/releases)

### eza

Eza serves as feature-richer ls alternative.

[![latest packaged version(s)](https://repology.org/badge/latest-versions/eza.svg)](https://repology.org/project/eza/versions)\
[![Debian 13 package](https://repology.org/badge/version-for-repo/debian_13/eza.svg)](https://repology.org/project/eza/versions)\
[![GitHub Release](https://img.shields.io/github/v/release/eza-community/eza?display_name=release&label=mise&color=brightgreen)](https://github.com/eza-community/eza/releases)

### fd-find

Fdfind serves as feature-richer find alternative.

[![latest packaged version(s)](https://repology.org/badge/latest-versions/fd-find.svg)](https://repology.org/project/fd-find/versions)\
[![Debian 13 package](https://repology.org/badge/version-for-repo/debian_13/fd-find.svg)](https://repology.org/project/fd-find/versions)\
[![GitHub Release](https://img.shields.io/github/v/release/sharkdp/fd?display_name=release&label=mise&color=brightgreen)](https://github.com/sharkdp/fd/releases)

### fish

Fish serves as the primary interactive shell.

[![latest packaged version(s)](https://repology.org/badge/latest-versions/fish.svg)](https://repology.org/project/fish/versions)\
[![Debian 13 package](https://repology.org/badge/version-for-repo/debian_13/fish.svg)](https://repology.org/project/fish/versions)

### git

Git serves as a source code manager.

[![latest packaged version(s)](https://repology.org/badge/latest-versions/git.svg)](https://repology.org/project/git/versions)\
[![Debian 13 package](https://repology.org/badge/version-for-repo/debian_13/git.svg)](https://repology.org/project/git/versions)

### git-delta

Delta serves as a git-diff tool.

[![latest packaged version(s)](https://repology.org/badge/latest-versions/git-delta.svg)](https://repology.org/project/git-delta/versions)\
[![Debian 13 package](https://repology.org/badge/version-for-repo/debian_13/git-delta.svg)](https://repology.org/project/git-delta/versions)\
[![GitHub Release](https://img.shields.io/github/v/release/dandavison/delta?display_name=release&label=mise&color=brightgreen)](https://github.com/dandavison/delta/releases)

### github-cli

Github-cli is used to register new ssh-keys with github, and downloading assets from github.

[![latest packaged version(s)](https://repology.org/badge/latest-versions/github-cli.svg)](https://repology.org/project/github-cli/versions)\
[![Debian 13 package](https://repology.org/badge/version-for-repo/debian_13/github-cli.svg)](https://repology.org/project/github-cli/versions)\
[![GitHub Release](https://img.shields.io/github/v/release/cli/cli?display_name=release&label=mise&color=brightgreen)](https://github.com/cli/cli/releases)

### glow

Glow serves as a CLI markdown renderer.

[![latest packaged version(s)](https://repology.org/badge/latest-versions/glow.svg)](https://repology.org/project/glow/versions)\
[![Debian 13 package](https://repology.org/badge/version-for-repo/debian_13/glow.svg)](https://repology.org/project/glow/versions)\
[![GitHub Release](https://img.shields.io/github/v/release/charmbracelet/glow?display_name=release&label=mise&color=brightgreen)](https://github.com/charmbracelet/glow/releases)

### gum-shell-tool

Glow serves as a library to enhance CLI tools.

[![latest packaged version(s)](https://repology.org/badge/latest-versions/gum-shell-tool.svg)](https://repology.org/project/gum-shell-tool/versions)\
[![Debian 13 package](https://repology.org/badge/version-for-repo/debian_13/gum-shell-tool.svg)](https://repology.org/project/gum-shell-tool/versions)\
[![GitHub Release](https://img.shields.io/github/v/release/charmbracelet/gum?display_name=release&label=mise&color=brightgreen)](https://github.com/charmbracelet/gum/releases)

### helix-editor

Helix serves as the primary editor.

[![latest packaged version(s)](https://repology.org/badge/latest-versions/helix-editor.svg)](https://repology.org/project/helix-editor/versions)\
[![Debian 13 package](https://repology.org/badge/version-for-repo/debian_13/helix-editor.svg)](https://repology.org/project/helix-editor/versions)\
[![GitHub Release](https://img.shields.io/github/v/release/helix-editor/helix?display_name=release&label=mise&color=brightgreen)](https://github.com/helix-editor/helix/releases)

### lazygit

Lazygit serves as a TUI for git.

[![latest packaged version(s)](https://repology.org/badge/latest-versions/lazygit.svg)](https://repology.org/project/lazygit/versions)\
[![Debian 13 package](https://repology.org/badge/version-for-repo/debian_13/lazygit.svg)](https://repology.org/project/lazygit/versions)\
[![GitHub Release](https://img.shields.io/github/v/release/jesseduffield/lazygit?display_name=release&label=mise&color=brightgreen)](https://github.com/jesseduffield/lazygit/releases)

### mise

Mise serves as a fallback installation tool if the distribution's repositories do not have a package listed.

[![latest packaged version(s)](https://repology.org/badge/latest-versions/mise.svg)](https://repology.org/project/mise/versions)\
[![Debian 13 package](https://repology.org/badge/version-for-repo/debian_13/mise.svg)](https://repology.org/project/mise/versions)\
[![GitHub Release](https://img.shields.io/github/v/release/jdx/mise?display_name=release&label=bootstrap&color=brightgreen)](https://github.com/jdx/mise/releases)

### numbat

Numbat serves as a CLI calculator with units as first class citizens.

[![latest packaged version(s)](https://repology.org/badge/latest-versions/numbat.svg)](https://repology.org/project/numbat/versions)\
[![Debian 13 package](https://repology.org/badge/version-for-repo/debian_13/numbat.svg)](https://repology.org/project/numbat/versions)\
[![GitHub Release](https://img.shields.io/github/v/release/sharkdp/numbat?display_name=release&label=mise&color=brightgreen)](https://github.com/sharkdp/numbat/releases)

### pastel-sharkdp

Pastel serves as a handy CLI tool for picking colours.

[![latest packaged version(s)](https://repology.org/badge/latest-versions/pastel-sharkdp.svg)](https://repology.org/project/pastel-sharkdp/versions)\
[![Debian 13 package](https://repology.org/badge/version-for-repo/debian_13/pastel-sharkdp.svg)](https://repology.org/project/pastel-sharkdp/versions)\
[![GitHub Release](https://img.shields.io/github/v/release/sharkdp/pastel?display_name=release&label=mise&color=brightgreen)](https://github.com/sharkdp/pastel/releases)

### ripgrep

Ripgrep serves as feature-richer grep alternative.

[![latest packaged version(s)](https://repology.org/badge/latest-versions/ripgrep.svg)](https://repology.org/project/ripgrep/versions)\
[![Debian 13 package](https://repology.org/badge/version-for-repo/debian_13/ripgrep.svg)](https://repology.org/project/ripgrep/versions)\
[![GitHub Release](https://img.shields.io/github/v/release/burntsushi/ripgrep?display_name=release&label=mise&color=brightgreen)](https://github.com/burntsushi/ripgrep/releases)

### topydo

Topydo serves as a todo.txt manager

[![latest packaged version(s)](https://repology.org/badge/latest-versions/topydo.svg)](https://repology.org/project/topydo/versions)\
[![Debian 13 package](https://repology.org/badge/version-for-repo/debian_13/topydo.svg)](https://repology.org/project/topydo/versions)\
[![GitHub Release](https://img.shields.io/github/v/release/topydo/topydo?display_name=release&label=mise&color=brightgreen)](https://github.com/topydo/topydo/releases)

### tldr-pages

Tldr-pages serves as a more modern man alternative.

[![latest packaged version(s)](https://repology.org/badge/latest-versions/tlrc.svg)](https://repology.org/project/tlrc/versions)\
[![Debian 13 package](https://repology.org/badge/version-for-repo/debian_13/tlrc.svg)](https://repology.org/project/tlrc/versions)\
[![GitHub Release](https://img.shields.io/github/v/release/tldr-pages/tlrc?display_name=release&label=mise&color=brightgreen)](https://github.com/tldr-pages/tlrc/releases)

### vivid

Vivid is a generator for the LS_COLORS environment variable

[![latest packaged version(s)](https://repology.org/badge/latest-versions/vivid.svg)](https://repology.org/project/vivid/versions)\
[![Debian 13 package](https://repology.org/badge/version-for-repo/debian_13/vivid.svg)](https://repology.org/project/vivid/versions)\
[![GitHub Release](https://img.shields.io/github/v/release/sharkdp/vivid?display_name=release&label=mise&color=brightgreen)](https://github.com/sharkdp/vivid/releases)
