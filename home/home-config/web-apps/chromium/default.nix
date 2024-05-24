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
    ./nix-search.nix
    ./pypi.nix
    ./kartoza-timesheets.nix
    ./kartoza-training.nix
    #./ms-teams.nix
    ./svg-repo.nix
    ./whatsapp.nix
  ];
}
