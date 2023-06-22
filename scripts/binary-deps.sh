#!/bin/bash

target_packages=("cargo-watch@8.4.0" "dum@0.1.19")

# ANSI escape sequences for text color
GREEN="\e[32m"
RED="\e[31m"
RESET="\e[0m"

install_packages() {
  for package in "${target_packages[@]}"; do
    echo -e "${GREEN}Installing $package...${RESET}"
    cargo install "$package"
  done
}

uninstall_packages() {
  for package in "${target_packages[@]}"; do
    echo -e "${RED}Uninstalling $package...${RESET}"
    cargo uninstall "$package"
  done
}

if [[ $# -ne 1 || ($1 != "install" && $1 != "uninstall") ]]; then
  echo "Usage: ./scripts/binary-deps.sh [install|uninstall]"
  exit 1
fi

if [[ $1 == "install" ]]; then
  install_packages
elif [[ $1 == "uninstall" ]]; then
  uninstall_packages
fi

echo -e "${GREEN}Cargo-binary-installation completed successfully.${RESET}"
