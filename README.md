# Rust-scripts-template

## Description
Script templates to help install Rustup and binary dependencies for Rust repositories

## Installation
You need to install rustup and binary deps of cargo using python to getting started.

| **Setup Rust envirioment**
```bash
./scripts/rustup.sh install # Install Rustup > download required Rustc
./scripts/rustup.sh uninstall # Uninstall Rustup
```

| **Setup Rust-cargo binary dependencies**
```bash
./scripts/binary-deps.sh install # Install deps
./scripts/binary-deps.sh uninstall # Uninstall deps
```