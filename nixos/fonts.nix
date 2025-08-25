{ pkgs, ... }@inputs:
{
  fonts.packages = with pkgs; [
    fira-code
    fira-math
    font-awesome
  ];

}
