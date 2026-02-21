{ nix-cachyos-kernel, pkgs, ... }:
{
  nixpkgs.overlays = [
    nix-cachyos-kernel.overlays.pinned
  ];

  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest;

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
        consoleMode = "max";
      };
      efi = {
        canTouchEfiVariables = true;
      };
    };
    supportedFilesystems = [
      "btrfs"
      "ntfs"
    ];

    plymouth = {
      enable = true;
      themePackages = [
        pkgs.plymouth-blahaj-theme
      ];
      theme = "blahaj";
    };

    kernelParams = [
      "quiet"
      "splash"
    ];
  };

  # Bluetooth battery
  hardware.bluetooth = {
    enable = true;
    settings = {
      General = {
        Experimental = true;
      };
    };
  };

  # Set your time zone.
  time = {
    timeZone = "Asia/Colombo";
  };

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.utf8";
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    excludePackages = [ pkgs.xterm ];
  };

  environment.gnome.excludePackages = (with pkgs; [ gnome-tour ]);

  # Enable the GNOME Desktop Environment.
  services = {
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  services = {
    # Power savings
    # power-profiles-daemon.enable = false;
    # auto-cpufreq.enable = true;

    scx = {
      enable = true;
      package = pkgs.scx.rustscheds;
      scheduler = "scx_bpfland";
    };
  };

  # ZRAM
  zramSwap = {
    enable = true;
    memoryPercent = 100;
  };

  fonts = {
    enableDefaultPackages = true;
    # Emoji fix
    fontconfig.useEmbeddedBitmaps = true;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
    ];
  };
}
