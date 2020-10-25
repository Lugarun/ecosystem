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

# future

- Do I make it a flake?
- move password store setup into secretes
