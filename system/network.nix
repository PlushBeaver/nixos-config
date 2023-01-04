{ inputs, ... }:

{
  networking = {
    hostName = "sovereign";

    useNetworkd = true;
    useDHCP = false;
    interfaces = { enp5s5.useDHCP = true; };

    firewall.enable = false;
  };

  services.resolved.extraConfig = ''
    DNSStubListenerExtra=172.17.0.1
  '';

  services.openssh.enable = true;
  programs.ssh.startAgent = true;

  programs.wireshark.enable = true;

  networking.wireguard.enable = true;
  networking.wireguard.interfaces."wg0" = let wg = inputs.secrets.wireguard;
  in {
    ips = [ "10.8.0.2/30" ];
    inherit (wg) privateKey;
    peers = [{
      inherit (wg) endpoint publicKey;
      allowedIPs = [ "10.8.0.1/32" ];
    }];
  };
}
