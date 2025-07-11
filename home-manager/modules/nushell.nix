{ lib, pkgs, ... }:
{
  programs = {
    nushell = {
      enable = true;
      configFile.text = # nu
        ''
          $env.config.buffer_editor = "hx"

          # Common ls aliases and sort them by type and then name
          # Inspired by https://github.com/nushell/nushell/issues/7190
          def lla [...args] { ls -la ...(if $args == [] {["."]} else {$args}) | sort-by type name -i }
          def la  [...args] { ls -a  ...(if $args == [] {["."]} else {$args}) | sort-by type name -i }
          def ll  [...args] { ls -l  ...(if $args == [] {["."]} else {$args}) | sort-by type name -i }
          def l   [...args] { ls     ...(if $args == [] {["."]} else {$args}) | sort-by type name -i }

          # Completions
          # mainly pieced together from https://www.nushell.sh/cookbook/external_completers.html

          # carapce completions https://www.nushell.sh/cookbook/external_completers.html#carapace-completer
          # + fix https://www.nushell.sh/cookbook/external_completers.html#err-unknown-shorthand-flag-using-carapace
          # enable the package and integration bellow
          let carapace_completer = {|spans: list<string>|
            carapace $spans.0 nushell ...$spans
            | from json
            | if ($in | default [] | where value == $"($spans | last)ERR" | is-empty) { $in } else { null }
          }
          # some completions are only available through a bridge
          # eg. tailscale
          # https://carapace-sh.github.io/carapace-bin/setup.html#nushell
          $env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense'

          # fish completions https://www.nushell.sh/cookbook/external_completers.html#fish-completer
          # let fish_completer = {|spans|
          #   ${lib.getExe pkgs.fish} --command $"complete '--do-complete=($spans | str join ' ')'"
          #   | from tsv --flexible --noheaders --no-infer
          #   | rename value description
          #   | update value {
          #       if ($in | path exists) {$'"($in | str replace "\"" "\\\"" )"'} else {$in}
          #   }
          # }

          # zoxide completions https://www.nushell.sh/cookbook/external_completers.html#zoxide-completer
          let zoxide_completer = {|spans|
              $spans | skip 1 | zoxide query -l ...$in | lines | where {|x| $x != $env.PWD}
          }

          # multiple completions
          # the default will be carapace, but you can also switch to fish
          # https://www.nushell.sh/cookbook/external_completers.html#alias-completions
          let multiple_completers = {|spans|
            ## alias fixer start https://www.nushell.sh/cookbook/external_completers.html#alias-completions
            let expanded_alias = scope aliases
            | where name == $spans.0
            | get -i 0.expansion

            let spans = if $expanded_alias != null {
              $spans
              | skip 1
              | prepend ($expanded_alias | split row ' ' | take 1)
            } else {
              $spans
            }
            ## alias fixer end

            match $spans.0 {
              __zoxide_z | __zoxide_zi => $zoxide_completer
              _ => $carapace_completer
            } | do $in $spans
          }

          $env.config = {
            show_banner: false,
            completions: {
              case_sensitive: false # case-sensitive completions
              quick: true           # set to false to prevent auto-selecting completions
              partial: true         # set to false to prevent partial filling of the prompt
              algorithm: "fuzzy"    # prefix or fuzzy
              external: {
                # set to false to prevent nushell looking into $env.PATH to find more suggestions
                enable: true 
                # set to lower can improve completion performance at the cost of omitting some options
                max_results: 100 
                completer: $multiple_completers
              }
            }
          } 

          $env.config.hooks.command_not_found = {
            |command_name|
            print (command-not-found $command_name | str trim)
          }

          # Environment variables
          let ANDROID = ($env.HOME | path join "Android/Sdk")
          let path_segments = [
            ($ANDROID | path join "tools")
            ($ANDROID | path join "tools/bin")
            ($ANDROID | path join "platform-tools")
            ($ANDROID | path join "emulator")
            ($env.HOME | path join ".bun/bin")
            ($env.HOME | path join ".cargo/bin")
          ]
          $env.PATH = ($path_segments | split row (char esep)) | append ($env.PATH | split row (char esep))

          # $env.PATH = ($env.PATH | 
          # split row (char esep) |
          # prepend /home/myuser/.apps |
          # append /usr/bin/env
          # )
          source ~/.zoxide.nu
        '';
    };

    carapace = {
      enable = true;
      enableNushellIntegration = true;
    };
  };
}
