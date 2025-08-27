let
    nixpkgs = import <nixpkgs> {
        config.allowUnfree = false;
        overlays = [ ];
    };
    platform_dependencies = if nixpkgs.stdenv.hostPlatform.system == "x86_64-darwin" then nixpkgs.darwin.apple_sdk.frameworks.Security
        else "";
in
    with nixpkgs;
    mkShell rec {
        packages = [
            # List packages that should be on the path
            # You can search for package names using nix-env -qaP | grep <name>
            stdenv clang nettle pkg-config capnproto sqlite rustc cargo llvm
            llvmPackages.libclang platform_dependencies rust-analyzer
            cargo-flamegraph
        ];
        buildInputs = [
            # List packages that should be on the path
            # You can search for package names using nix-env -qaP | grep <name>
            stdenv clang nettle pkg-config capnproto sqlite rustc cargo llvm
            llvmPackages.libclang platform_dependencies rust-analyzer
        ];
        LIBCLANG_PATH = libclang.lib + "/lib";


    }
