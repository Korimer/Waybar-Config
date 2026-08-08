{ lib, pkgs, ... }:

with lib;

let
  moduleType = types.submodule {
    options = {
      name = mkOption {
        type = types.str;
        example = "battery";
      };

      settings = mkOption {
        type = types.attrsOf types.anything;
        default = {};
      };

      css = mkOption {
        type = types.attrsOf (types.attrsOf types.str);
        default = {};
      };
    };
  };

  barType = types.submodule {
    options = {
      modulesLeft = mkOption {
        type = types.listOf moduleIdType;
        default = [];
      };

      modulesCenter = mkOption {
        type = types.listOf moduleIdType;
        default = [];
      };

      modulesRight = mkOption {
        type = types.listOf moduleIdType;
        default = [];
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
    };

    moduleDefinitions = mkOption {
      type = types.listOf moduleType;
    };

    extraCss = mkOption {
      type = types.lines;
      default = "";
    };

    groups = mkOption {
      type = types.attrsOf (types.listOf moduleId);
      default = {};
    };

    bars = mkOption {
      type = types.attrsOf barType;
      default = {};
      description = "Waybar bars.";
    };
  };
}
