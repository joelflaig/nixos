# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

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
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.joel = {
    isNormalUser = true;
    description = "Joel";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

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

    # bootloader
    grub2 # grub -- bootloader

    # boot
    plymouth # plymouth -- boot splash/logger

    # display manager
    sddm # sddm -- display manager

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
    yazi # yazi -- file manager
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

