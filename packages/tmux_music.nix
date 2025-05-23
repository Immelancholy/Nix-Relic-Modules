{writeShellScriptBin, ...}:
writeShellScriptBin "tmusic" ''
    i=0
    sesh="Music"

    # Check if the session already exists
    while tmux has-session -t $sesh 2>/dev/null; do
      ((i++))
      sesh="$sesh$i"
    done
  #!/usr/bin/env bash
  tmux new -d -s "$sesh" "inori"

  tmux set -g status off

  tmux splitw -h -p 60 "artis"

  tmux select-pane -t 1

  tmux attach-session -t "$sesh"
''
