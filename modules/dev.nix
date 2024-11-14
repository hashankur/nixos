{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    ## Editor / IDE
    vscode.fhs
    zed-editor_git
    # androidStudioPackages.beta
    # arduino-ide

    ## Compilers / Runtimes
    nodejs
    bun
    # python3
    rustup

    ## Tools
    # contrast
    # gaphor
    # gcc
    # scrcpy
    nh
    # docker-compose

    ## LSP
    # nil
    nixfmt-rfc-style
    nixd
    nodePackages_latest.vscode-langservers-extracted
    nodePackages_latest.typescript-language-server
    nodePackages_latest."@tailwindcss/language-server"
    marksman
    # lua-language-server
  ];

  programs = {
    git = {
      enable = true;
      config = {
        init = {
          defaultBranch = "main";
        };
      };
    };

    adb.enable = true;

    java = {
      enable = true;
      package = pkgs.temurin-bin;
    };

    direnv.enable = false;

    nix-ld = {
      enable = true;
      libraries =
        with pkgs;
        [
          xorg.libxkbfile
        ]
        ++ pkgs.steam-run.fhsenv.args.multiPkgs pkgs;
    };
  };

  # services = {
  #   mysql = {
  #     enable = false;
  #     package = pkgs.mariadb;
  #   };
  # };

  # virtualisation.docker.enable = true;
}
