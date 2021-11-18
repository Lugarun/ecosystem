{
  description = "Home Manager Configuration";

  inputs = {};
  outputs = { self, ... }: {
    config = import ./home.nix;
  };
}
