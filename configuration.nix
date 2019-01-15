# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

#users
users.users.bun = {
	isNormalUser = true;
	home = "/home/bun";
	description = "bun";
	extraGroups = [ "wheel" "networkmanager" ];
};


#Boot
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";

#fonts
fonts.fonts = with pkgs; [
	fira-code
	font-awesome-ttf
	];

#Network
  networking.hostName = "bun";
  networking.networkmanager.enable = true;
  networking.firewall.allowedTCPPorts = [];
  networking.firewall.allowedUDPPorts = [];

#rescue shell
  i18n = {
    consoleKeyMap = "dk";
    defaultLocale = "en_US.UTF-8";
  };

#timezone
  time.timeZone = "Europe/Copenhagen";

#default packages and settings
  environment.systemPackages = with pkgs;
  [
    ack
    acpitool
    ag
    bluez
    chromium
    clang
    clojure
    cmake
    compton
    cquery
    curl
    dtrx
    emscripten
    emacs
    feh
    gcc
    git
    gnumake
    go
    i3status-rust
    irony-server
    leiningen
    mpv
    qutebrowser
    rustc
    spotify
    steam
    terminator
    zathura
    zsh
  ];
  nixpkgs.config.allowUnfree = true;

#Default shell
  programs.zsh.enable = true;
  users.extraUsers.bun = {
	shell = pkgs.zsh;
	};

#openssh
  services.openssh.enable = true;

#sound
  sound.enable = true;
  hardware.pulseaudio.enable = true;

#xserver
  services.xserver =
   {
	enable = true;
	layout = "dk";
	libinput.enable = true;
	xkbOptions = "caps:escape";
	desktopManager.default = "none";
	windowManager.i3.enable = true;
};

#backlight
  programs.light.enable = true;

#misc
  system.stateVersion = "18.09";
  services.printing.enable = true;

}
