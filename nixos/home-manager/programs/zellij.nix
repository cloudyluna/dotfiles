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
                  name = "Main";
                  focus = true;
                };
                _children = [
                  {
                    pane = {
                      command = "emacs";
                      args = [
                        "-nw"
                      ];
                    };
                  }
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
                  name = "Docs: NixOS";
                };
                _children = [
                  {
                    pane = {
                      split_direction = "horizontal";
                      command = "man";
                      args = "home-configuration.nix";
                    };
                  }
                  {
                    pane = {
                      command = "man";
                      args = "configuration.nix";
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
                      # Install manually first with cargo install --git https://github.com/ckampfe/russ
                      command = "russ read";
                    };
                  }
                ];
              };
            }
            {
              tab = {
                _props = {
                  name = "Shell";
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
          ];
        };
      };
    };
  };
}
