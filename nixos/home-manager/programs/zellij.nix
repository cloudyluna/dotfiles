{ config, ... }:
let
  home = config.home;
in
rec {

  programs.zellij = {
    enable = true;
    attachExistingSession = false;
    exitShellOnExit = false;
    enableBashIntegration = false;
    enableFishIntegration = false;
    extraConfig = ''
      show_startup_tips false
      default_mode "locked"
      keybinds {
          unbind "Ctrl g"
          locked {
                  bind "Super g" {
                          SwitchToMode "normal"
                  }
          }
          normal {
                  bind "Super g" {
                          SwitchToMode "locked"
                  }
          }
      }
    '';

    layouts = {
      dev = {
        layout = {
          _children = [
            {
              default_tab_template = {
                _children = [
                  {
                    pane = {
                      size = 1;
                      borderless = true;
                      plugin = {
                        location = "zellij:tab-bar";
                      };
                    };
                  }
                  { "children" = { }; }
                  {
                    pane = {
                      size = 2;
                      borderless = true;
                      plugin = {
                        location = "zellij:status-bar";
                      };
                    };
                  }
                ];
              };
            }
            {
              tab = {
                _props = {
                  name = "Main Shell";
                  focus = true;
                };
                _children = [
                  {
                    pane = {
                      split_direction = "horizontal";
                    };
                  }
                ];
              };
            }
            {
              tab = {
                _props = {
                  name = "Misc Shell";
                };
                _children = [
                  {
                    pane = {
                      command = "fish";
                    };
                  }
                ];
              };
            }
            {
              tab = {
                _props = {
                  name = "News";
                };
                _children = [
                  {
                    pane = {
                      command = "russ";
                      args = [
                        "read"
                      ];
                    };
                  }
                ];
              };
            }
          ];
        };
      };
    };
  };
}
