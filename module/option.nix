{ lib, pkgs, ... }:

with lib;

let
  moduleType = types.submodule {
    options = {
      module = mkOption {
        type = types.str;
        description = "Waybar module name.";
        example = "battery";
      };

      instance = mkOption {
        type = types.ints.positive;
        default = 1;
        description = ''
          Module instance number.

          Instances are emitted as `<module>#<instance>`, matching Waybar's
          native multiple-instance syntax.
        '';
        example = 2;
      };

      settings = mkOption {
        type = types.attrsOf types.anything;
        default = {};
        description = "Configuration for this module instance.";
        example = {
          bat = "BAT1";
        };
      };

      css = mkOption {
        type = types.attrsOf (types.attrsOf types.str);
        default = {};
        description = ''
          CSS declarations for this module instance.

          The outer attribute name is an optional CSS class suffix. An empty
          string targets the module instance itself.

          Example:

            css = {
              "" = {
                color = "#e0af68";
              };

              "critical" = {
                color = "#ffffff";
              };
            };

          For a battery module with `instance = 2`, this generates:

            #battery.i2 {
              color: #e0af68;
            }

            #battery.i2.critical {
              color: #ffffff;
            }
        '';
      };
    };
  };
in
{
  options.programs.waybar = {
    enable = mkEnableOption "Waybar";

    package = mkOption {
      type = types.package;
      default = pkgs.waybar;
      defaultText = literalExpression "pkgs.waybar";
      description = "The Waybar package to use.";
    };

    extraCss = mkOption {
      type = types.lines;
      default = "";
      description = ''
        Additional CSS appended to the generated Waybar stylesheet.
      '';
    };

    modulesLeft = mkOption {
      type = types.listOf moduleType;
      default = [];
      description = "Modules displayed on the left side of the bar.";
    };

    modulesCenter = mkOption {
      type = types.listOf moduleType;
      default = [];
      description = "Modules displayed in the center of the bar.";
    };

    modulesRight = mkOption {
      type = types.listOf moduleType;
      default = [];
      description = "Modules displayed on the right side of the bar.";
    };

    groups = mkOption {
      type = types.attrsOf (types.listOf moduleType);
      default = {};
      description = ''
        Named groups of Waybar modules.
      '';
    };
  };
}
