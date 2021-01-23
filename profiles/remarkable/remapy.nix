{ lib, buildPythonPackage, fetchPypi, python3 }:
mkderivation rec {
  name = "remapy":
  src = fetchFromGithub {
    owner = "peerdavid";
    repo = "remapy";
    rev = "01872d20104fb6174ac03b2693b443707eb3c9a4";
    sha256 = "0rs9bxxrw4wscf4a8yl776a8g880m5gcm75q06yx2cn3lw2b7v22";
  };
  buildInputs = [ python3 ];
  installPhase = ''
    mkdir -p $out/bin
  '';

}
