# nixos-asahi-starter
Basic NixOS flake template for configuring a nixos system on apple silicon.
The intention is to be used after installing NixOS using [nixos-asahi-package](https://github.com/quinneden/nixos-asahi-package)
because the configuration of the disk image used to bootstrap the NixOS system
is less than optimal, and not flake based. However, this configuration doesn't
depend on having used the asahi-installer method and should work for any
NixOS installation on apple silicon hardware.

# Init new flake
```bash
mkdir -p your/config/path
cd your/config/path
git init
nix flake init -t github:quinneden/nixos-asahi-starter
git add .
```

Modify the configuration as needed, I recommend regenerating nixos/hardware-configuration.nix
using nixos-generate-config, however if you installed NixOS with the asahi-installer
package, the existing hardware config should work.

```bash
nixos-generate-config --show-hardware-config | tee nixos/hardware-configuration.nix
```

# Rebuild
```bash
nixos-rebuild switch --flake .#nixos --show-trace
```
