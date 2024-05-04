{
  pkgs,
  config,
  lib,
  ...
}: {
  imports = [
    ./chat-gpt.nix
    ./kartoza-erp.nix
    ./kartoza-geocommunity.nix
    ./kartoza-timesheets.nix
    ./ms-teams.nix
    ./nix-search.nix
  ];
}
