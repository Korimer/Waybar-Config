{ pkgs, lib, config, ... }:

let
  toService = barName: barConfig:
    let
      location = import ./shared/barLocation.nix barName barConfig;
    in
    {
      name = "waybar-${barName}";

      value = {
        description = "Waybar for ${barName}";
        wantedBy = [ "graphical-session.target" ];

        serviceConfig = {
          ExecStart =
            "${lib.getExe pkgs.waybar} --config /etc/${location.config} --style /etc/${location.style}";
          Restart = "on-failure";
        };
      };
    };

  enabledBars =
    lib.filterAttrs
      (_: bar: bar.enable)
      config.programs.waybar.bars;
in
{
  systemd.user.services = lib.mapAttrs' toService enabledBars;
}
