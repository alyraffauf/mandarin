let
  hosts = [
    "mandarin"
  ];
  users = [
    "aly_fallarbor"
    "aly_lavaridge"
    "aly_mauville"
    "aly_petalburg"
    "aly_rustboro"
    "morgan_mandarin"
  ];
  systemKeys = builtins.map (host: builtins.readFile ./publicKeys/root_${host}.pub) hosts;
  userKeys = builtins.map (user: builtins.readFile ./publicKeys/${user}.pub) users;
  keys = systemKeys ++ userKeys;
in {
  "tailscale/authKeyFile.age".publicKeys = keys;
}
