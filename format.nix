{ config, lib, pkgs, modulesPath, ... }:

{
  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    autoResize = true;
    fsType = "ext4";
  };

  boot = {
    growPartition = true;
    kernelParams = [ "console=ttyS0" ];
    loader.grub.device = lib.mkDefault "/dev/vda";
    loader.timeout = 5;
    initrd.availableKernelModules = [ "uas" "sdhci_pci" ];
  };


  system.build.raw = import "${toString modulesPath}/../lib/make-disk-image.nix" {
    inherit lib config pkgs;
    diskSize = "auto";
    format = "raw";
  };

  formatAttr = "raw";
  filename = "*.img";
}