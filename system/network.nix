{ inputs, ... }:

{
  networking = {
    hostName = "sovereign";

    useNetworkd = true;
    useDHCP = false;
    interfaces = {
      enp4s4.useDHCP = false;
      enp5s5.useDHCP = true;
    };

    firewall.enable = false;
  };

  services.openssh.enable = true;
  programs.ssh.startAgent = true;

  programs.wireshark.enable = true;

  services.openvpn.servers.rho.config = inputs.secrets.vpnConfig;
}
