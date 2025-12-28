{
  pkgs,
  credentials,
  config,
  lib,
  inputs,
  ...
}:

let
in
rec {

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
  ];

  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
      publicShare = null;
      templates = null;
    };
    autostart = {
      enable = true;
      entries = [
        "${pkgs.audacious}/share/applications/audacious.desktop"
      ];
    };
    desktopEntries = {
      # Alacritty top level name should be PascalCase
      # to override existing desktop file.
      Alacritty =
        let
          zellijExec = "alacritty -e zellij --layout ${home.homeDirectory}/.config/zellij/layouts/dev.kdl";
        in
        {
          name = "Alacritty";
          type = "Application";
          genericName = "Terminal";
          exec = zellijExec;
          terminal = false;
          startupNotify = true;
          categories = [
            "System"
            "TerminalEmulator"
          ];
          icon = "Alacritty";
          comment = "A fast, cross-platform, OpenGL terminal emulator";

          actions = {
            "new-terminal" = {
              name = "New Terminal Without Zellij";
              exec = "alacritty";
            };
            "new-terminal-zellij" = {
              name = "New Terminal With Zellij";
              exec = zellijExec;
            };
          };
        };
    };
  };
  home.preferXdgDirectories = true;
  home.username = credentials.user.name;
  home.homeDirectory = "/home/${credentials.user.name}";

  home.file = {
    # FIXME: Cannot set files with specific permissions.
    # See https://github.com/nix-community/home-manager/issues/3090

    ".emacs" = {
      source = ./data/.emacs;
    };

    ".nanorc" = {
      source = ./data/.nanorc;
    };

    ".quick-emacs.el" = {
      source = ./data/.quick-emacs.el;
    };

    ".rss-bookmarks.json" = {
      source = ./data/.rss-bookmarks.json;
    };

    "Pictures/wallpapers" = {
      source = ./data/wallpapers;
      recursive = true;
    };

  };

  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/.cargo/bin"
  ];

  home.sessionVariables = {
    EDITOR = "emacs -Q --no-window-system --load $HOME/.quick-emacs.el";
    GSK_RENDERER = "gl";
  };

  home.shellAliases = {
    "gc" = "git clone";
    "gs" = "git status";
    "gd" = "git diff";
    "list-generations" = "nix profile history --profile /nix/var/nix/profiles/system";
  };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "*" = {
        addKeysToAgent = "yes";
      };
    };
  };

  programs.git = {
    enable = true;
    signing = {
      format = "ssh";
      signByDefault = true;
      key = "${home.homeDirectory}/.ssh/id_momo.pub";
    };
    settings = {
      user = {
        name = credentials.user.name;
        email = credentials.user.email;
        init = {
          defaultbranch = "main";
        };
      };
    };
  };

  programs.bat = {
    enable = true;
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      line-numbers = true;
    };
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      # Don't do that shell init greetings ever again!
      set fish_greeting
    '';
  };

  programs.direnv.enable = true;
  programs.autojump.enable = true;
  programs.yazi.enable = true;
  programs.lazygit = {
    enable = true;
    settings = {
      git = {
        autoFetch = false;
        autoRefresh = false;
      };
    };
  };

  programs.zellij = {
    enable = true;
    attachExistingSession = true;
    exitShellOnExit = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    extraConfig = ''
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
                      split_direction = "horizontal";
                    };
                  }

                  {
                    pane = {
                      command = "emacs";
                      args = [
                        "-nw"
                      ];
                    };
                  }
                ];
              };
            }
            {
              tab = {
                _props = {
                  name = "fzf: $HOME";
                };
                _children = [
                  {
                    pane = {
                      command = "fzf";
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
                  name = "Files";
                };
                _children = [
                  {
                    pane = {
                      command = "yazi";
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
                      # Install manually first with cargo install feedr.
                      command = "feedr";
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

  programs.zed-editor = {
    enable = true;
    extensions = [
      "nix"
    ];
    extraPackages = with pkgs; [
      nixd
    ];
    userSettings = {
      enable_ai = false;
      telemetry = {
        metrics = false;
      };
    };
  };

  programs.alacritty = {
    enable = true;
    theme = "monokai";
    settings = {
      window = {
        opacity = 0.9;
        startup_mode = "Maximized";
        title = "Terminal";
      };

      scrolling = {
        history = 100000;
      };

      selection = {
        save_to_clipboard = true;
      };

      cursor = {
        style = {
          shape = "Block";
          blinking = "On";
        };
      };
    };
  };

  gtk = {
    enable = true;
    colorScheme = "dark";
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
  };

  # Using the following example configuration, Qt applications
  # will have a look similar to the adwaita style used by GNOME
  # using a dark theme.
  qt = {
    enable = true;
    platformTheme.name = "adwaita";
    style = {
      name = "adwaita-dark";
      package = pkgs.adwaita-qt6;
    };
  };

  imports = [ ./dconf.nix ];

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
