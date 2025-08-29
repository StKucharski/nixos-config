{config, lib, ...}:
{
    virtualisation.docker = {
      enable = true;
    };

    users.users.cooke.extraGroups = ["docker"];
}
