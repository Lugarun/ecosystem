## Home-manager Setup
Make sure you have nix installed.
Then get the password store setup to import your secrets
```bash
nix-shell -p gpg pass git
gpg --import password-store.key
git clone "password-store git repo" ~/.password-store
```

# My setup
I try to keep as much as my config as possible in home-manager
so that I can 'easily' port my environment (including desktop-manager)
to a different host.

So here is my break down:
```bash
secrets # contains my secrets using git-crypt
```

Note that my hardware config is done via a [different repo](https://github.com/Lugarun/biome).

# Inspiration

- https://github.com/lovesegfault/nix-config
- https://github.com/nrdxp/nixflk
- https://git.bytes.zone/brian/dotfiles.nix
- https://github.com/alexherbo2

# Future

- kakoune
  - setup kak-gdb
  - setup kakoune gdb (https://github.com/occivink/kakoune-gdb)
  - setup kak-sudo-write
  - make fzf ignore .git directory (https://github.com/andreyorst/fzf.kak)
  - kak remote file editing?
- zotero
  - automatically install zotero-better-bibtex extension
