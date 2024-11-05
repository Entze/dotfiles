# Entze's Dotfiles

A dotfile repository, managed by [chezmoi](https://chezmoi.io).

## Installation

For every supported operating system includes, under `bootstrap/` in this
repository, a self-contained script to bootstrap the dotfiles. Specifically, it
will install [mise](#mise), [chezmoi](#chezmoi), and [git](#git).

Use the following command to initialize, and apply the configuration.

```bash
chezmoi init --apply -- $GITHUB_USER
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

Eza serves as a more feature-rich ls alternative.

[![latest packaged version(s)](https://repology.org/badge/latest-versions/eza.svg)](https://repology.org/project/eza/versions)\
[![Debian 13 package](https://repology.org/badge/version-for-repo/debian_13/eza.svg)](https://repology.org/project/eza/versions)\
[![GitHub Release](https://img.shields.io/github/v/release/eza-community/eza?display_name=release&label=mise&color=brightgreen)](https://github.com/eza-community/eza/releases)

### fd-find

Fdfind serves as a more feature-rich find alternative.

[![latest packaged version(s)](https://repology.org/badge/latest-versions/fd-find.svg)](https://repology.org/project/fd-find/versions)\
[![Debian 13 package](https://repology.org/badge/version-for-repo/debian_13/fd-find.svg)](https://repology.org/project/fd-find/versions)\
[![GitHub Release](https://img.shields.io/github/v/release/sharkdp/fd?display_name=release&label=mise&color=brightgreen)](https://github.com/sharkdp/fd/releases)

### fish

Fish serves as the primary interactive shell.

[![latest packaged version(s)](https://repology.org/badge/latest-versions/fish.svg)](https://repology.org/project/fish/versions)\
[![Debian 13 package](https://repology.org/badge/version-for-repo/debian_13/fish.svg)](https://repology.org/project/fish/versions)

### flox

Flox serves as a development environment manager.

[![latest packaged version(s)](https://repology.org/badge/latest-versions/flox-dev-environments.svg)](https://repology.org/project/flox-dev-environments/versions)\
[![Debian 13 package](https://repology.org/badge/version-for-repo/debian_13/flox-dev-environments.svg)](https://repology.org/project/flox-dev-environments/versions)\
[![GitHub Release](https://img.shields.io/github/v/release/flox/flox?display_name=release&label=deb&color=brightgreen)](https://github.com/flox/flox/releases)

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
