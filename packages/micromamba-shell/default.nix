{ pkgs ? import <nixpkgs> {}}:
let
  micromambaInitRun = pkgs.writeText "micromamba-init-run.sh" (builtins.readFile ./micromamba-init-run.sh);
  micromambaInitProfile = pkgs.writeText "micromamba-init-profile.sh" (builtins.readFile ./micromamba-init-profile.sh);
in
pkgs.buildFHSEnv {
    name = "micromamba-shell";

    targetPkgs = _: [
      pkgs.micromamba
      pkgs.bash-completion
    ];
    
    profile = ''
        set -ex
                
        # Source micromamba initialization script
        source ${micromambaInitProfile}
        
        # Configure an exclusive conda set up
        micromamba config append channels conda-forge
        micromamba config append channels nodefaults
        micromamba config set channel_priority strict
        
        # Activate the base environment
        micromamba activate
        set +e

    '';

runScript = "bash --init-file ${micromambaInitRun}";

}