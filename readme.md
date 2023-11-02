## Home-manager Setup
Make sure you have nix installed.
Then get the password store setup to import your secrets
```{.sh pipe="bash"}
nix-shell -p gpg pass git
gpg --import password-store.key
git clone "password-store git repo" ~/.password-store
```

# My setup
I try to keep as much as my config as possible in home-manager
so that I can 'easily' port my environment (including desktop-manager)
to a different host.

So here is my break down:

```{.python pipe="python"}
print("ls")
```

```{.sh pipe="bash"}
echo hello world
pwd
```


Note that my hardware config is done via a [different repo](https://github.com/Lugarun/biome).

# Setup Steps

I install this setup through the biome nixos setup.
Here are the additional setup setps you need to take :( :

1. Set the Zotero `Data Directory Location` to `/home/lukas/projects/zotero`
2. If using emacs install then doom
3. Run `rmapi` to authenticate rmapi with the remarkable cloud
4. Install zotero extension (zotfile)[http://zotfile.com/] and then:
  - Set zotfile New Files directory to the downloads folder
  - Enable zotfile tablet ability
  - Set zotfile location to `/home/lukas/projects/zotfile`

# Inspiration

- https://github.com/lovesegfault/nix-config
- https://github.com/nrdxp/nixflk
- https://git.bytes.zone/brian/dotfiles.nix
- https://github.com/alexherbo2
- package shell scripts: https://www.ertt.ca/nix/shell-scripts/
- https://myme.no/posts/2020-01-26-nixos-for-development.html

# Future

- kakoune
  - setup kak-gdb
  - setup kakoune gdb (https://github.com/occivink/kakoune-gdb)
  - setup kak-sudo-write
  - make fzf ignore .git directory (https://github.com/andreyorst/fzf.kak)
  - kak remote file editing?
- zotero
  - automatically install zotero-better-bibtex extension

