{
  config,
  pkgs,
  appimageTools,
  fetchurl,
}: let
  pname = "koodo-reader";
  version = "1.6.9";

  src = fetchurl {
    url = "https://github.com/koodo-reader/koodo-reader/releases/download/v${version}/Koodo-Reader-${version}-x86_64.AppImage";
    hash = "42b8d9977657ef4267c17226e4e64f3ffcaa942781c18033574f42a0fe287c3f";
  };
in
  appimageTools.wrapType2 {
    inherit pname version src;
  }
