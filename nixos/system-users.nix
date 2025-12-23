{ pkgs, credentials, ... }@inputs:
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${credentials.user.name} = {
    shell = pkgs.fish;
    isNormalUser = true;
    description = credentials.user.description;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };
}
