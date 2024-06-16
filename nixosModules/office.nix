{ pkgs, username, ... }:
{
  services.avahi.enable = true; # service discovery (for example printers)
  services.avahi.nssmdns = true; # resolving xyz.local
  services.avahi.openFirewall = true;
  services.printing = {
    enable = true;
    drivers = with pkgs; [ gutenprint foomatic-db ];
  };
  hardware.sane = {
    enable = true;
    extraBackends = [ pkgs.sane-airscan ];
  };

  users.users.${username}.extraGroups = [ "wheel" "input" "scanner" "lp" ];
}
