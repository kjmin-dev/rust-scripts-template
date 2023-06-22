#!/bin/sh

# Define color escape sequences
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Check if rustup is installed
check_rustup_installed() {
  command -v rustup >/dev/null 2>&1
}

# Install rustup
install_rustup() {
  if [ "$(uname)" = "Darwin" ]; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    source $HOME/.cargo/env
  else
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source $HOME/.cargo/env
  fi
}

# Uninstall rustup
uninstall_rustup() {
  rustup self uninstall -y
}

# Install rustc with rustup-toolchain according to the specified version
install_rustc_with_toolchain() {
  rustup install $1
}

# Uninstall rustc with rustup-toolchain
uninstall_rustc_with_toolchain() {
  rustup uninstall $1
}

# Create and save the rust-toolchain file with the specified version in the current directory
create_rust_toolchain_file() {
  echo $1 > rust-toolchain
}

main() {
  # Check if rustup is installed
  if ! check_rustup_installed; then
    echo "${YELLOW}rustup is not installed. Installing rustup...${NC}"
    install_rustup
  else
    echo "${GREEN}rustup is already installed. Updating rustup...${NC}"
    rustup update
  fi

  # Read the version from the rust-toolchain file
  version=$(cat rust-toolchain)

  # Install, uninstall rustc, or uninstall rustup based on the command-line argument
  if [ "$1" = "install" ]; then
    echo "${YELLOW}Installing rustc $version...${NC}"
    install_rustc_with_toolchain $version
  elif [ "$1" = "uninstall" ]; then
    echo "${RED}Uninstalling rustc $version...${NC}"
    uninstall_rustc_with_toolchain $version
    echo "${RED}Uninstalling rustup...${NC}"
    uninstall_rustup
  else
    echo "${RED}Invalid command. Usage: ./script_name.sh [install|uninstall]${NC}"
    exit 1
  fi

  # Create and save the rust-toolchain file with the specified version in the current directory
  create_rust_toolchain_file $version

  echo "${GREEN}Process completed.${NC}"
}

main "$@"
