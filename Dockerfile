FROM nixos/nix

RUN nix-channel --add https://github.com/NixOS/nixos-hardware/archive/master.tar.gz nixos-hardware
RUN nix-env --install git nano bash tmux rxvt-unicode
#RUN nix-env -iA nixpkgs.qemu_kvm
RUN nix-env -f https://github.com/nix-community/nixos-generators/archive/master.tar.gz -i
RUN nix-channel --update



