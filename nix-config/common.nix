#
#  Tools that are common across all instances
#
{ pkgs, vars, ... }:

{
  programs.zsh.enable = true;

  environment = {
    systemPackages = with pkgs; [
      age # asymmetric encryption tool
      pandoc # text document conversion

      eza # Ls
      git # Version Control
      # nnn # File Manager
      yazi # File Manager
      tldr # Help

      bat
      bfs
      coreutils-full
      curl
      delta # CLI diff viewer
      entr
      fd
      findutils
      fzf
      gawk
      gettext
      gnupg
      gnutar
      hexyl
      htop
      jq
      lazygit
      lua5_4_compat
      mise
      mutagen
      pass
      tree
      ripgrep
      rsync
      shellcheck
      yq-go
    ];
  };
}
