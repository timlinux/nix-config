{ pkgs, ... }:

{
  # Add system wide fonts
  environment.systemPackages = with pkgs; [
    maple-mono-NF
    nerdfonts
  }
}

