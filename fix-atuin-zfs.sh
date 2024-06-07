sudo zfs create -V 50MB NIXROOT/atuin
sudo zfs list -o name,encryption | grep atuin # ensure encryption for the zvol
nix-shell -p e2fsprogs.bin --run 'sudo mkfs.ext4 /dev/zvol/NIXROOT/atuin'
mv ~/.local/share/atuin ~/.local/share/atuin-backup
mkdir ~/.local/share/atuin
sudo mount /dev/zvol/NIXROOT/atuin ~/.local/share/atuin
sudo chown -R ${USER}: ~/.local/share/atuin
cp -rv ~/.local/share/atuin-backup/* ~/.local/share/atuin 
