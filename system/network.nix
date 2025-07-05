{ inputs, ... }:

{
  networking = {
    hostName = "sovereign";

    useNetworkd = true;
    useDHCP = false;
    interfaces = {
      enp5s5.useDHCP = true;
    };

    firewall.enable = false;
  };

  systemd.network.wait-online.anyInterface = true;

  services.resolved.extraConfig = ''
    DNSStubListenerExtra=172.17.0.1
  '';

  services.openssh.enable = true;
  programs.ssh.startAgent = true;

  programs.wireshark.enable = true;
}
