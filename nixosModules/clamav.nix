{ pkgs, ... }:
{
  services.clamav = {
    scanner.enable = true;
    updater = { enable = true; interval = "daily"; };
  };
}
