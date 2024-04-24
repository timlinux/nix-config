{ config, pkgs, ... }:
{
  environment.etc."kartoza-ca-cert.crt" = {
    mode = "0555";
    source = ../resources/kartoza-ca-cert.crt;
  };
}
