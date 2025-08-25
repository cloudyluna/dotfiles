{ pkgs, credentials, ... }@inputs:
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${credentials.userName} = {
    shell = pkgs.fish;
    isNormalUser = true;
    description = credentials.description;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };
}
