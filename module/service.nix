{ pkgs, lib, config, ... }:

let
  toService = barName: barConfig:
    let
      location = import ./shared/barLocation.nix barName barConfig;
    in
    {
      name = "${barName}-waybar";

      value = {
        description = "Waybar for ${barName}";
        wantedBy = [ "graphical-session.target" ];

        serviceConfig = {
          ExecStart =
            "${lib.getExe pkgs.waybar} --config ${location.config} --style ${location.style}";
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
  systemd.services = lib.mapAttrs' toService enabledBars;
}
