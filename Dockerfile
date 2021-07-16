FROM nixos/nix

RUN nix-env --install git nano
RUN nix-channel --add https://github.com/NixOS/nixos-hardware/archive/master.tar.gz nixos-hardware
RUN nix-channel --update