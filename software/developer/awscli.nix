{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    awscli2
  ];
  environment.variables = {
    AWS_S3_ENDPOINT = "s3.af-south-1.amazonaws.com";
    AWS_NO_SIGN_REQUEST = "YES";
    AWS_DEFAULT_REGION = "af-south-1"; # e.g., "us-west-2"
  };
}
