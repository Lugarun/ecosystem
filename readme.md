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
so that I can setup my environment (including desktop-manager)
justing using nix-env on a different host.

So here is my break down:
```bash
hosts # contains bare bones host configurations (just to set up hardware specific configurations)
secrets # contains my secrets using git-crypt
```

# taken inspiration from
- https://github.com/lovesegfault/nix-config
- https://github.com/nrdxp/nixflk
- https://git.bytes.zone/brian/dotfiles.nix
- https://github.com/alexherbo2

# future

- tell xmonad on startup to create a workspace and open up discord, matterhorn, telegram, and a email client (I keep missing one of the chats and then I miss tasks that I need to do) Ideally there would be some client that can handle all of the above like franz but I can't fond one that is light weight, opensources, and keeps data local.
- kakoune
  - better markdown syntax highlighting (```{.python} should use python syntax highlighting )
  - setup kak-gdb
  - setup kakoune gdb (https://github.com/occivink/kakoune-gdb)
  - setup kak-sudo-write
  - make fzf ignore .git directory (https://github.com/andreyorst/fzf.kak)
  - kak remote file editing?
