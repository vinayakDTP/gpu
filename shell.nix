let
  pkgs = import <nixpkgs> { };

  unstable = import
    (builtins.fetchTarball "https://github.com/NixOS/nixpkgs/archive/8001cc402f61b8fd6516913a57ec94382455f5e5.tar.gz")
    # reuse the current configuration
    { config = pkgs.config; };
in
(pkgs.buildFHSUserEnv {
  name = "kernel-build-env";
  targetPkgs = pkgs: (with pkgs;
    [
      unstable.zls
      unstable.zig_0_13
      python3Full
      pkg-config
      openssl
      nano
      libelf
      meson
      python3
      wayland-protocols
      ncurses.dev
      qemu
      file
      wget
      libxcrypt
      gdb
      clang-tools
      git
      which
      gcc
      unzip
      flock
      openssh
    ]
    ++ pkgs.linux.nativeBuildInputs);
 shellHook = ''
    echo "Running shellHook"
    export PKG_CONFIG_PATH=/home/pumpum/gpu_testing_env-master/build/buildroot/host/x86_64-buildroot-linux-gnu/sysroot/usr/share/pkgconfig:/home/pumpum/gpu_testing_env-masterbuild/buildroot/build/wayland-protocols-1.36/build:$PKG_CONFIG_PATH
'';
}).env
