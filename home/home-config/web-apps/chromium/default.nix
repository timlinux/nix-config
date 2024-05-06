{
  pkgs,
  config,
  lib,
  ...
}: {
  imports = [
    ./chat-gpt.nix
    ./google-calendar.nix
    ./google-mail.nix
    ./kartoza-erp.nix
    ./kartoza-geocommunity.nix
    ./kartoza-handbook.nix
    ./kartoza-timesheets.nix
    ./kartoza-training.nix
    #./ms-teams.nix
    ./nix-search.nix
    ./svg-repo.nix
  ];
}
