{
  username,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  boot = {
    m1n1CustomLogo = "fixme";
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = false;
    };
  };

  hardware.asahi = {
    withRust = true;
    setupAsahiSound = true;
    useExperimentalGPUDriver = true;
    experimentalGPUInstallMode = "replace";
  };

  networking = {
    networkmanager.enable = true;
    networkmanager.wifi.backend = "iwd";
    wireless.iwd = {
      enable = true;
      settings.General.EnableNetworkConfiguration = true;
    };
  };

  nix.settings = {
    warn-dirty = false;
    auto-optimise-store = true;
    experimental-features = ["nix-command" "flakes"];
    trusted-users = ["${username}" "root"];
    extra-nix-path = "nixpkgs=flake:nixpkgs";
    extra-substituters = [
      "${secrets.cachix.nixos-asahi.url}"
      "https://cache.lix.systems"
    ];
    extra-trusted-public-keys = [
      "${secrets.cachix.nixos-asahi.public-key}"
      "cache.lix.systems:aBnZUw8zA7H35Cz2RyKFVs3H4PlGTLawyY5KRbvJR8o="
    ];
  };

  zramSwap = {
    enable = true;
    memoryPercent = 100;
  };

  users.mutableUsers = true;
  users.users."${username}" = {
    initialPassword = "${username}";
    isNormalUser = true;
    extraGroups = ["wheel"];
    packages = with pkgs; [
      git
      eza
      micro
      ripgrep
      asahi-bless
    ];
  };

  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";

  system.stateVersion = "24.11";
}
