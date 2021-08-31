#!/bin/env bash

selected=$(tmux list-sessions -F "#{session_name}" | fzf)
[ -z $selected ] && exit

tmux switch -t "$selected"
