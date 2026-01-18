# Install

## Copy repository

```sh
git clone --bare git@github.com:theStrangeAdventurer/dotfiles.git $HOME/.dotfiles
```

## Define dotfiles alias in shell

```sh
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dotfiles config --local status.showUntrackedFiles no
```

## Checkout content to $HOME

```sh
dotfiles checkout || {
  echo "Backing up pre-existing dotfiles to .dotfiles-backup"
  mkdir -p .dotfiles-backup
  dotfiles checkout 2>&1 | grep -E "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dotfiles-backup/{}
  dotfiles checkout
}
```

## Install hooks

```sh
chmod +x $HOME/dotfiles-entry/scripts/setup-hooks.sh
$HOME/dotfiles-entry/scripts/setup-hooks.sh
# Trigger the hook by running checkout again
dotfiles checkout
```

