#!/bin/sh
# Fuzzy-pick a tmux session or zoxide dir and connect via sesh (bound to prefix f)
s=$(sesh list -t -c -z -d -H | fzf --with-shell 'sh -c' --reverse --prompt 'session> ' --preview 'sesh preview {}') && sesh connect "$s"
