{ pkgs, lib, config, ... }:

let
  toService = barName: barConfig:
    let
      location = import ./shared/barLocation.nix barName barConfig;
    in
    {
      "${barName}-waybar" = {
        name = "${barName}-waybar";
        description = "Waybar for ${barName}";
        wantedBy = [ "graphical-session.target" ];

        serviceConfig = {
          ExecStart = "${lib.getExe pkgs.waybar} --config ${location.config} --style ${location.css}";
          Restart = "on-failure";
        };
      };
    };

  enabledBars = lib.filterAttrs (_: bar: bar.enable) config.programs.waybar.bars;
in
{
  systemd.services = lib.mapAttrs' toService enabledBars;
}
