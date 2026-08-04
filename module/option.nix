{ lib, pkgs, ... }:

with lib;

let
  moduleType = types.submodule {
    options = {
      module = mkOption {
        type = types.str;
        description = "Waybar module name.";
      };

      instance = mkOption {
        type = types.int;
        default = 1;
        description = "Waybar module instance number.";
      };

      settings = mkOption {
        type = types.attrsOf types.anything;
        default = {};
        description = "Configuration for this module.";
      };

      css = mkOption {
        type = types.attrsOf (types.attrsOf types.str);
        default = {};
        description = "CSS-related attributes for this module.";
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
      description = "Additional CSS appended to the generated Waybar stylesheet.";
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
      description = "Named groups of Waybar modules.";
    };
  };
}
