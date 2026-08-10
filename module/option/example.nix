{ pkgs, ... }:
{
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    
    bars.myAwesomeWaybar = {
      barConfig = {
      };

      groups = {
        generalStats = [
          {
            name = "group/heatStats";
            settings.orientation = "orthogonal";
          }
          {
            name = "group/resourceUsage";
            settings.orientation = "orthogonal";
          }
        ];

        heatStats = [
          {
            name = "temperature";
            settings = {
              hwmon-path = "/sys/class/hwmon/hwmon0/temp1_input";
              format = " {temperatureC}°C";
              tooltip = true;
            };
            style.base = {
              color = "#f38ba8";
            };
          }
        ];

        resourceUsage = [
          {
            name = "cpu";
            settings = {
              interval = 2;
              format = " {usage}%";
              tooltip = true;
            };
            style.base = {
              color = "#89b4fa";
            };
          }

          {
            name = "memory";
            settings = {
              interval = 2;
              format = " {percentage}%";
              tooltip = true;
            };
            style.base = {
              color = "#a6e3a1";
            };
          }
        ];

        utilities = [
          {
            name = "bluetooth";
            settings = {
              format = "󰂯 {status}";
              format-disabled = "󰂲";
              format-off = "󰂲";
              format-on = "󰂯";
              format-connected = "󰂱 {device_alias}";
              tooltip = true;
            };
            style.base = {
              color = "#89b4fa";
            };
          }


          {
            name = "battery";
            settings = {
              format = "{capacity}%";
              format-charging = " {capacity}%";
              format-full = " {capacity}%";
              tooltip = true;
            };
            style.base = {
              color = "#f9e2af";
            };
          }
        ];
      };

      modulesLeft = [
        {
          name = "group/generalStats";
          style.bySelector." *" = {
            margin = "0 5px";
          };
        }
        {
          name = "pulseaudio";
          settings = {
            format = "{icon} {volume}%";
            format-muted = "󰝟 muted";
            format-icons = {
              base = [ "󰕿" "󰖀" "󰕾" ];
            };
            tooltip = true;
            on-click = "pavucontrol";
          };

          style = {
            base = {
              color = "#f9e2af";
              background-color = "#89b4fa";
            };
            bySelector.".muted" = {
              background-color = "#aa99aa";
            };
          };
        }
      ];

      modulesCenter = [
        {
          name = "wlr/taskbar";
          settings = {
            on-click = "activate";
            on-click-middle = "close";
            on-click-right = "minimize";
          };
        }
      ];

      modulesRight = [
        {
          name = "group/utilities";
          settings = {
            orientation = "inherit";
            drawer = {};
          };
        }
      ];
    };

    extraCss = ''

    '';
  };
}
