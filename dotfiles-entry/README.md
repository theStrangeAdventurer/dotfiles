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
  b=.dotfiles-backup; mkdir -p "$b"
  dotfiles checkout 2>&1 | sed -n 's/^[[:space:]]*\(\.[^[:space:]]*\).*/\1/p' |
  while IFS= read -r f; do [ -e "$f" ] || continue; mkdir -p "$b/$(dirname "$f")"; mv -- "$f" "$b/$f"; done
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

