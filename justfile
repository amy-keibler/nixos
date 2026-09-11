set default-list := true

# Flake update
update:
  nix flake update

# Apply the current configuration
apply:
  sudo nixos-rebuild switch --flake '.#'

# Update the flake and apply the config
the-works: update apply
