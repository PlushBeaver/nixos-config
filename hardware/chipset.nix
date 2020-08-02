{ ... }:

{
  hardware.enableAllFirmware = true;
  hardware.enableRedistributableFirmware = true;

  boot.initrd.availableKernelModules = [
    "ahci"
    "sd_mod"
    "usb_storage"
    "usbhid"
    "xhci_pci"
  ];
}
