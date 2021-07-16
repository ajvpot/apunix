# custom-iso.nix

{ nixpkgs ? <nixpkgs>, system ? "x86_64-linux" }:

let
  myisoconfig = { config, pkgs, ... }: {
    imports = [
      <nixos-hardware/pcengines/apu>
      "${nixpkgs}/nixos/modules/profiles/minimal.nix"
      "${nixpkgs}/nixos/modules/installer/sd-card/sd-image.nix"
    ];
      # boot.loader.grub.enable = false;
     #  boot.loader.generic-extlinux-compatible.enable = true;
     boot.loader.grub.devices = ["/dev/disk/by-label/NIXOS_SD"];

  sdImage = {
  compressImage = false;
    populateFirmwareCommands =''
    '';
    populateRootCommands = ''
    '';
  };

    networking.hostName = "mynixos"; services.nginx.enable = true;
    environment.systemPackages = with pkgs; [ tmux vim ];
    users.extraUsers.root.password = "mynixos";
  };

  evalNixos = configuration: import "${nixpkgs}/nixos" {
    inherit system configuration;
  };

in { iso = (evalNixos myisoconfig).config.system.build.sdImage; }