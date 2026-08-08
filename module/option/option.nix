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
      enable = mkOption {
        type = types.bool;
        default = true;
      };

      barConfig = mkOption {
        type = import ./barConfig.nix {inherit lib;};
        default = {};
      };

      groups = mkOption {
        type = types.attrsOf (types.listOf moduleType);
        default = {};
      };

      modulesLeft = mkOption {
        type = types.listOf moduleType;
        default = [];
      };

      modulesCenter = mkOption {
        type = types.listOf moduleType;
        default = [];
      };

      modulesRight = mkOption {
        type = types.listOf moduleType;
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

    extraCss = mkOption {
      type = types.lines;
      default = "";
    };

    bars = mkOption {
      type = types.attrsOf barType;
      default = {};
      description = "Waybar bars.";
    };
  };
}
