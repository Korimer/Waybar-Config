{ lib, ... }:
with lib;
types.submodule {
  options = {
    layer = mkOption {
      type = types.enum [ "top" "bottom" ];
      default = "bottom";
      description = "Display the bar in front of or behind windows.";
    };

    output = mkOption {
      type = types.listOf types.str;
      default = [ ];
      description = "Screens on which to display the bar.";
    };

    position = mkOption {
      type = types.enum [ "top" "bottom" "left" "right" ];
      default = "top";
      description = "Position of the bar.";
    };

    height = mkOption {
      type = types.nullOr types.int;
      default = null;
      description = "Height of the bar. Null leaves the value dynamic.";
    };

    width = mkOption {
      type = types.nullOr types.int;
      default = null;
      description = "Width of the bar. Null leaves the value dynamic.";
    };

    modules-left = mkOption {
      type = types.listOf types.str;
      default = [ ];
      description = "Modules displayed on the left.";
    };

    modules-center = mkOption {
      type = types.listOf types.str;
      default = [ ];
      description = "Modules displayed in the center.";
    };

    modules-right = mkOption {
      type = types.listOf types.str;
      default = [ ];
      description = "Modules displayed on the right.";
    };

    margin = mkOption {
      type = types.nullOr types.str;
      default = null;
      description = "CSS-style margin without units.";
    };

    margin-top = mkOption {
      type = types.nullOr types.int;
      default = null;
      description = "Top margin.";
    };

    margin-left = mkOption {
      type = types.nullOr types.int;
      default = null;
      description = "Left margin.";
    };

    margin-bottom = mkOption {
      type = types.nullOr types.int;
      default = null;
      description = "Bottom margin.";
    };

    margin-right = mkOption {
      type = types.nullOr types.int;
      default = null;
      description = "Right margin.";
    };

    spacing = mkOption {
      type = types.int;
      default = 4;
      description = "Gap between modules.";
    };

    name = mkOption {
      type = types.nullOr types.str;
      default = null;
      description = "Optional CSS class name for the bar.";
    };

    mode = mkOption {
      type = types.nullOr (
        types.enum [ "dock" "hide" "invisible" "overlay" ]
      );
      default = null;
      description = "Preconfigured display mode.";
    };

    start_hidden = mkOption {
      type = types.bool;
      default = false;
      description = "Whether the bar starts hidden.";
    };

    modifier-reset = mkOption {
      type = types.enum [ "press" "release" ];
      default = "press";
      description = "When the modifier key resets bar visibility.";
    };

    exclusive = mkOption {
      type = types.bool;
      default = true;
      description = "Request an exclusive zone from the compositor.";
    };

    fixed-center = mkOption {
      type = types.bool;
      default = true;
      description = "Prefer a fixed center position for modules-center.";
    };

    passthrough = mkOption {
      type = types.bool;
      default = false;
      description = "Pass pointer events through the bar.";
    };

    ipc = mkOption {
      type = types.bool;
      default = false;
      description = "Subscribe to Sway IPC bar configuration and visibility events.";
    };

    id = mkOption {
      type = types.nullOr types.str;
      default = null;
      description = "bar_id used for Sway IPC.";
    };

    include = mkOption {
      type = types.listOf types.str;
      default = [ ];
      description = "Additional Waybar configuration files to include.";
    };

    reload_style_on_change = mkOption {
      type = types.bool;
      default = false;
      description = "Reload CSS when the stylesheet or an imported stylesheet changes.";
    };

    on-sigusr1 = mkOption {
      type = types.enum [ "show" "hide" "toggle" "reload" "noop" ];
      default = "toggle";
      description = "Action performed when receiving SIGUSR1.";
    };

    on-sigusr2 = mkOption {
      type = types.enum [ "show" "hide" "toggle" "reload" "noop" ];
      default = "reload";
      description = "Action performed when receiving SIGUSR2.";
    };
  };
}
