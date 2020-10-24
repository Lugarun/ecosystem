## Home-manager Setup
Make sure you have nix installed.
Then get the password store setup to import your secrets
```bash
nix-shell -p gpg pass git
gpg --import password-store.key
git clone "password-store git repo" ~/.password-store
```
