# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Hardware.
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  hardware.pulseaudio.enable = false;

  # Bootloader.
  boot = {
    plymouth = {
      enable = true;
      theme = "pixels";
      themePackages = with pkgs; [
        # By default we would install all themes
        (adi1090x-plymouth-themes.override {
          selected_themes = [ "pixels" ];
        })
      ];
    };

    # Enable "Silent Boot"
    consoleLogLevel = 0;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];
    # Hide the OS choice for bootloaders.
    # It's still possible to open the bootloader list by pressing any key
    # It will just not appear on screen unless a key is pressed
    # loader.timeout = 0; # Warning!: did not work for grub when I tested it.

    loader.grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
    };

    loader.systemd-boot.enable = false;
    loader.efi.canTouchEfiVariables = true;
  };

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Configure keymap in X11
  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.defaultUserShell = pkgs.zsh;
  users.users.joel = {
    isNormalUser = true;
    description = "Joel";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Services

  # SDDM
  services.displayManager.sddm = {
    enable = true;
    # wayland.enable = true;
  };

  # PipeWire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;
  };

  # Printing
  # services.printing = {
    # enable = true;
    # drivers = with pkgs; [
      # gutenprint
      # hplip
    # ];
  # };

  # Avahi
  # services.avahi = {
    # enable = true;
    # nssmdns4 = true;
    # openFirewall = true;
  # };


  # Environment variables
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Program configs
  programs.zsh = {
    syntaxHighlighting.enable = true;
    enable = true;
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Fonts
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code-nerdfont
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # well, idk
    vim
    wget

    # audio
    pipewire # pipewire -- audio
    wireplumber # session/policy manager for PipeWire

    # hyprland
    hyprland # hyprland -- window manager
    hyprpicker # hyprpicker -- color picker
    xdg-desktop-portal-hyprland # xdg-desktop-portal-hyprland -- xdg-desktop-portal backend for hyprland
    xdg-desktop-portal-gtk # xdg-desktop-portal-gtk -- xdg-desktop-portal backend for gtk


    # bootloader
    grub2 # grub -- bootloader

    # boot
    plymouth # plymouth -- boot splash/logger

    # display manager
    sddm # sddm -- display manager

    # app launcher & menu
    wofi # wofi -- dmenu & drun replacement

    # dotfiles
    stow

    # terminal
    kitty # terminal
    zsh # shell
    tmux # tmux -- terminal multiplexer
    starship # starship -- shell prompt
    zsh-syntax-highlighting # zsh-syntax-highlighting -- syntax highlighting for zsh
    zsh-autosuggestions # zsh-autosuggestions -- suggestions for zsh
    zsh-autopair # zsh-autopair -- brackets, quotes, etc.
    zsh-vi-mode # zsh-vi-mode -- better vi mode
    thefuck # thefuck -- corrects command mistakes

    # rice
    pipes # pipes.sh -- animated pipes terminal screensaver
    cmatrix # cmatrix -- matrix effect

    # languages
    libgcc # gcc -- C/C++ compiler
    llvm_18 # llvm -- compiler framework
    lua # lua -- lua interpreter
    nodejs_22 # nodejs -- javascript
    rustup # rustup -- rust language
    go # go -- golang

    # editing
    neovim # neovim -- editor

    # git
    git # git -- version management
    lazygit # lazygit -- git client
    delta # delta -- diff tool
    gh # gh -- github cli
    git-lfs # git-lfs -- git large file storage

    # finders
    fzf # fzf -- fuzzy finder
    fd # fd -- find files
    ripgrep # ripgrep -- grep replacement

    # files && folders
    yazi # yazi -- TUI file manager
    dolphin # dolphin -- GUI file manager
    zoxide # zoxide -- cd replacement
    stow # stow -- symlink manager
    bat # bat -- cat with syntax highlighting
    eza # eza -- ls replacement

    # misc
    sl # sl -- steam locomotive
    yq # yq -- yaml, json, xml processor
    btop # btop++ -- command line task manager
    man # man -- docs

    # web
    firefox # firefox -- web browser

    # notes
    obsidian # obsidian -- note taking

    # recording
    obs-studio # obs studio -- screen recording

    # notifications
    dunst # dunst -- notification daemon
    libnotify # libnotify -- notify-send

    # authentication
    kdePackages.polkit-kde-agent-1

    # discord -- chat
    discord

    # clipboard
    wl-clipboard # wl-clipboard -- clipboard manager
    wl-clip-persist # wl-clip-persist -- keep wl-clipboard after program closes
    clipse # clipse -- tui clipboard manager

    # automount
    udiskie # udiskie -- automount usb drives

    # zip
    unzip # unzip -- unzip tool

    # fetch
    neofetch # neofetch -- system information tool

    # clock
    gnome.gnome-clocks # gnome-clocks -- clock

    # speech
    speechd

    # images
    loupe # loupe -- image viewer

    # wallpaper
    swww # swww -- wallpaper manager

    # office
    wpsoffice # wps office -- Free MS compatible office suite

    # printers
    # cups # CUPS -- UNIX printing system
    gutenprint # gutenprint drivers -- open source printer drivers
    hplip # hp printer drivers
    system-config-printer # printer manager
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}

