# Gonçalo's dotfiles

This repo contains my dotfiles, used across Linux and macOS.

![Preview](preview.png)

Nothing is assumed to be installed, but the following are sourced if present:
* [rupa/z](https://github.com/rupa/z) from `~/.z.sh`
* [junegunn/fzf](https://github.com/junegunn/fzf) from `~/.fzf.bash`
* [asdf-vm/asdf](https://github.com/asdf-vm/asdf) and completions from the default locations

# Vim

My vimrc is kept in another repo: [goncalossilva/vimrc](https://github.com/goncalossilva/vimrc).

# Setup

1. `git clone --separate-git-dir=$HOME/.dotfiles git@github.com:goncalossilva/dotfiles.git $HOME/dotfiles`
2. `cp -r $HOME/dotfiles/. $HOME/ && rm -r $HOME/dotfiles/`
3. Source `~/.bashrc` or reload the shell
4. `dotfiles config status.showUntrackedFiles no`

All done. To add something:

```
dotfiles add .vimrc
dotfiles commit -m "Add vimrc"
```

Inspired by [this HN comment](https://news.ycombinator.com/item?id=11071754).
