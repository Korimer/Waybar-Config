{ pkgs, ... }:
{
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    
    bars.myAwesomeWaybar = {
      barConfig = {
      };

      groups = {
        heatStats = [
          {
            name = "temperature";
            settings = {
              hwmon-path = "/sys/class/hwmon/hwmon0/temp1_input";
              format = " {temperatureC}°C";
              tooltip = true;
            };
            css = {
              temperature = {
                color = "#f38ba8";
              };
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
            css = {
              cpu = {
                color = "#89b4fa";
              };
            };
          }

          {
            name = "memory";
            settings = {
              interval = 2;
              format = " {percentage}%";
              tooltip = true;
            };
            css = {
              memory = {
                color = "#a6e3a1";
              };
            };
          }
        ];

        utilities = [
          {
            name = "network";
            settings = {
              format-wifi = "󰤨 {essid}";
              format-ethernet = "󰈀 {ifname}";
              format-disconnected = "󰤭";
              tooltip = true;
            };
            css = {
              network = {
                color = "#cba6f7";
              };
            };
          }

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
            css = {
              bluetooth = {
                color = "#89b4fa";
              };
            };
          }

          {
            name = "pulseaudio";
            settings = {
              format = "{icon} {volume}%";
              format-muted = "󰝟 muted";
              format-icons = {
                default = [ "󰕿" "󰖀" "󰕾" ];
              };
              tooltip = true;
              on-click = "pavucontrol";
            };
            css = {
              pulseaudio = {
                color = "#f9e2af";
              };
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
            css = {
              battery = {
                color = "#f9e2af";
              };
            };
          }
        ];
      };

      modulesLeft = [
        {
          name = "custom/swaync";
          settings = {
          };
        }
        {
          name = "group/utilities";
          settings = {
            orientation = "orthogonal";
          };
        }
        {
          name = "tray";
          settings = {
            icon-size = 18;
            spacing = 10;
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
        {
          name = "niri/workspaces";
        }
      ];

      modulesRight = [
        {
          name = "group/resourceUsage";
          settings = {
            orientation = "orthogonal";
          };
        }
        {
          name = "group/heatStats";
          settings = {
            orientation = "orthogonal";
          };
        }

      ];
    };

    extraCss = ''

    '';
  };
}
