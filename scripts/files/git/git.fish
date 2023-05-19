#!/usr/bin/env fish

# git diff check
function git
    if test "$argv[1]" = "diff"
        gd $argv[2..-1]
    else
        command git $argv
    end
end
