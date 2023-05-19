#!/usr/bin/env fish

# git diff wrapper for diff-so-fancy
function gd --wraps='git diff' --description='Show a fancy diff with git'
  command git diff --color=always $argv | diff-so-fancy
end
