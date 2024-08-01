{
  pkgs,
  config,
  lib,
  ...
}: {
  imports = [
    ./chat-gpt.nix
    ./drawdb.nix
    ./google-calendar.nix
    ./google-drive.nix
    ./google-chat.nix
    ./google-mail.nix
    ./google-meet.nix
    ./kartoza-erp.nix
    ./kartoza-geocommunity.nix
    ./kartoza-handbook.nix
    ./nix-search.nix
    ./pypi.nix
    ./kartoza-timesheets.nix
    ./kartoza-sentry.nix
    ./kartoza-ntfy.nix
    ./kartoza-training.nix
    #./ms-teams.nix
    ./svg-repo.nix
    ./whatsapp.nix
  ];
}
