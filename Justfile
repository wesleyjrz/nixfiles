########################
### Local Deployment ###
########################

# Apply current system configuration (default option)
deploy:
  # vanilla command: sudo nixos-rebuild switch --flake ".#$(hostname)"
  nh os switch . --ask

# Apply current system configuration on the next boot
boot:
  # vanilla command: sudo nixos-rebuild boot --flake ".#$(hostname)"
  nh os boot .

# Apply current system configuration temporarily (until reboot)
test:
  # vanilla command: sudo nixos-rebuild test --flake ".#$(hostname)"
  nh os test .

# Run system activation in dry mode with trace enabled
dry-activate:
  sudo nixos-rebuild dry-activate --flake ".#$(hostname)" --show-trace --verbose

# Run tests
debug:
  nix flake check

# Update flake.nix and apply current system configuration
upgrade: # NOTE: vanilla command requires to run update
  # vanilla command: sudo nixos-rebuild boot --flake ".#$(hostname)"
  nh os boot . --update --ask

# Build a virtual machine with the current configuration
build-vm hostname:
  sudo nixos-rebuild build-vm --flake ".#{{hostname}}"

# Clean all files/symlinks left by the virtual machines
clean-vm:
  rm -f ./result
  rm -f ./*.qcow2

#########################
### Remote Deployment ###
#########################

# Deploy given host remotely
deploy-remote hostname:
  nixos-rebuild --flake ".#hydra" --target-host {{hostname}} \
  --build-host {{hostname}} switch --use-remote-sudo

# Debug given host remotely
debug-remote hostname:
  nixos-rebuild --flake ".#hydra" --target-host {{hostname}} \
  --build-host {{hostname}} \
  dry-activate --use-remote-sudo --show-trace --verbose

###########################
### System Installation ###
###########################

# Format disks for the given host
disko hostname:
	sudo disko --mode destroy,format,mount \
	./hosts/{{hostname}}/disk-configuration.nix

# Install NixOS in the given host
install hostname:
  sudo nixos-install --flake ".#{{hostname}}"

#####################
### Miscellaneous ###
#####################

# Update flake.nix, but do not apply current system configuration
update:
  nix flake update

# Format all files
format:
  alejandra **
