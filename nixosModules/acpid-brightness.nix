{ pkgs, ... }: {
  services.acpid = {
    enable = true;
    handlers =
      let
        event-to-action = {
          "video/brightnessup" = "${pkgs.brightnessctl}/bin/brightnessctl set +10%";
          "video/brightnessdown" = "${pkgs.brightnessctl}/bin/brightnessctl set 10%-";
        };
      in
      builtins.listToAttrs (map
        (event: {
          name = builtins.replaceStrings [ "/" ] [ "-" ] event;
          value = {
            inherit event;
            action = event-to-action.${event};
          };
        })
        (builtins.attrNames event-to-action));
  };
}
