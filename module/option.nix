{ lib, pkgs, ... }:

with lib;

let
  moduleIdType = types.submodule {
    options = {
      module = {
        type = types.str;
        example = "battery";
      };

      instance = mkOption {
        type = types.ints.positive;
        default = 1;
      };
    };
  };
  
  moduleType = types.submodule {
    options = {
      id = mkOption {
        type = moduleIdType;
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
      type = types.listOf barType;
      default = [];
      description = "Waybar bars.";
    };
  };
}
