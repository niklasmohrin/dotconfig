{ username, ... }:
{
  # virtualisation.virtualbox.host.enable = true;
  virtualisation = {
    docker.enable = true;
    podman.enable = true;
    # libvirtd = {
    #   enable = true;
    #   qemu.ovmf.enable = true;
    # };
  };

  users.users.${username}.extraGroups = ["docker"];
}
