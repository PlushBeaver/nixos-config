{ pkgs, ... }:

{
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  users.users."dmitry" = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = [ "audio" "docker" "kvm" "users" "wheel" "wireshark" ];
  };
}
