{
  config,
  ...
}:
let
  home = config.home;
in
{
  programs.alacritty = {
    enable = true;
    theme = "monokai";
    settings = {
      window = {
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
}
