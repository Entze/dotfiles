# Entze's Dotfiles

A dotfile repository, managed by [chezmoi](https://chezmoi.io).

## Installation

For every supported operating system includes, under `bootstrap/` in this
repository, a self-contained script to bootstrap the dotfiles. Specifically, it
will install [git](#git), [mise](#mise), and [chezmoi](#chezmoi). Furthermore it
will set essential environment variables.

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
[![Debian 13 package](https://repology.org/badge/version-for-repo/debian_13/bash.svg)](https://repology.org/project/bash/version)

### helix

Helix serves as the primary editor.

[![latest packaged version(s)](https://repology.org/badge/latest-versions/helix-editor.svg)](https://repology.org/project/helix-editor/versions)\
[![Debian 13 package](https://repology.org/badge/version-for-repo/debian_13/helix-editor.svg)](https://repology.org/project/helix-editor/version)\
[![GitHub Release](https://img.shields.io/github/v/release/helix-editor/helix?display_name=release&label=mise&color=brightgreen)](https://github.com/helix-editor/helix/releases)
