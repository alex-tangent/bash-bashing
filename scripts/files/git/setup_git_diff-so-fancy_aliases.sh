#!/bin/bash

# Creates git aliases for fish with diff-so-fancy
# Source used: https://gist.githubusercontent.com/0livare/4960a81addfbcdc48abfe855fae0af43/raw/9ea68f99fd53eb64f0ca84ebc7b37f1b0e46b0c4/.gitconfig

functions_dir=~/.config/fish/functions/git_aliases

# Delete directory if it exists
if [ -d "$functions_dir" ]; then
    rm -rf "$functions_dir"
fi

mkdir -p "$functions_dir"

# git diff check
echo 'function git; if test "$argv[1]" = "diff"; then gd $argv[2..-1]; else command git $argv; fi; end' > "$functions_dir/../git.fish"

# git diff wrapper
echo 'function gd; command git diff --color=always $argv | diff-so-fancy; end' > "$functions_dir/gd.fish"

# Common Commands
echo 'function gs; git status; end' > "$functions_dir/gs.fish"
echo 'function gb; git branch; end' > "$functions_dir/gb.fish"
echo 'function ga; git add .; end' > "$functions_dir/ga.fish"
#echo 'function gd; git difftool; end' > "$functions_dir/gd.fish"
echo 'function gm; git mergetool; end' > "$functions_dir/gm.fish"
echo 'function gf; git fetch --all --prune; end' > "$functions_dir/gf.fish"
echo 'function gpo; git push origin; end' > "$functions_dir/gpo.fish"
echo 'function gpu; git push upstream; end' > "$functions_dir/gpu.fish"
echo 'function gcp; git cherry-pick; end' > "$functions_dir/gcp.fish"
echo 'function gcpcont; git cherry-pick --continue; end' > "$functions_dir/gcpcont.fish"
echo 'function grh; git reset --hard; end' > "$functions_dir/grh.fish"
echo 'function gr; git rebase; end' > "$functions_dir/gr.fish"
echo 'function grcont; git rebase --continue; end' > "$functions_dir/grcont.fish"
echo 'function gra; git rebase --abort; end' > "$functions_dir/gra.fish"
echo 'function grem; git remote; end' > "$functions_dir/grem.fish"
echo 'function gpr; git remote prune; end' > "$functions_dir/gpr.fish"
echo 'function gprune; git remote prune; end' > "$functions_dir/gprune.fish"
echo 'function grd; git range-diff; end' > "$functions_dir/grd.fish"
echo 'function gpushf; git push --force-with-lease; end' > "$functions_dir/gpushf.fish"

# Assorted
echo 'function gstu; git stash show -p | git apply -R; end' > "$functions_dir/gstu.fish"
echo "function galias; grep -E '(  =|^$)' ~/.gitconfig | sed -E -e 's/=.+#//' | less; end" > "$functions_dir/galias.fish"
echo 'function gal2; git config -l | grep alias | cut -c 7-; end' > "$functions_dir/gal2.fish"
echo 'function gmff; git merge --ff-only; end' > "$functions_dir/gmff.fish"
echo 'function gmnf; git merge --no-ff; end' > "$functions_dir/gmnf.fish"
echo 'function grmh; git remote set-head origin -d; end' > "$functions_dir/grmh.fish"
echo 'function gignore; git rm -r --cached . && git add .; end' > "$functions_dir/gignore.fish"
echo 'function gorig; find -name "*.orig" -delete; end' > "$functions_dir/gorig.fish"
echo 'function ghide; git update-index --skip-worktree; end' > "$functions_dir/ghide.fish"
echo 'function gunhide; git update-index --no-skip-worktree; end' > "$functions_dir/gunhide.fish"

# File Management
echo 'function gdisc; git checkout --; end' > "$functions_dir/gdisc.fish"
echo 'function gco; git checkout; end' > "$functions_dir/gco.fish"
echo 'function gcob; git checkout -b; end' > "$functions_dir/gcob.fish"

# Commit Commands
echo 'function gcm; git commit -n; end' > "$functions_dir/gcm.fish"
echo 'function gcom; git commit -nm; end' > "$functions_dir/gcom.fish"
echo 'function gcam; git commit -nam; end' > "$functions_dir/gcam.fish"
echo 'function gamend; git commit -n --amend; end' > "$functions_dir/gamend.fish"
echo 'function gfix; git commit -n --amend --no-edit; end' > "$functions_dir/gfix.fish"
echo 'function gafix; git add . && git fix; end' > "$functions_dir/gafix.fish"
echo 'function gfixup; git add . && git fix && git push up --force-with-lease; end' > "$functions_dir/gfixup.fish"
echo "function gtmp; git commit -nm 'WIP - incremental commit'; end" > "$functions_dir/gtmp.fish"
echo 'function gatmp; git add . && git tmp; end' > "$functions_dir/gatmp.fish"

# Working with Previous Commit Commands
echo 'function gr1; git reset HEAD^; end' > "$functions_dir/gr1.fish"
echo 'function gr2; git reset HEAD^^; end' > "$functions_dir/gr2.fish"
echo 'function gf1; git reset HEAD@{1}; end' > "$functions_dir/gf1.fish"
echo 'function gd1; git difftool HEAD^ HEAD; end' > "$functions_dir/gd1.fish"
echo 'function gd2; git difftool HEAD^^ HEAD; end' > "$functions_dir/gd2.fish"
echo 'function gdoc; /c/batch/diffOneCommit.bat; end' > "$functions_dir/gdoc.fish"
echo 'function gdh; git remote set-head origin -d; end' > "$functions_dir/gdh.fish"
echo 'function gdname; git diff --name-only; end' > "$functions_dir/gdname.fish"

# Branch Management
echo 'function gdbr; git push origin --delete; end' > "$functions_dir/gdbr.fish"
echo "function gparbra; git branch | grep '' | sed 's/ //'; end" > "$functions_dir/gparseBranchName.fish"
echo 'function gpub; git parseBranchName | xargs git po -u; end' > "$functions_dir/gpublish.fish"
echo 'function gpushup; git rev-parse --abbrev-ref HEAD | xargs -I {} git push up {}:zp/{}; end' > "$functions_dir/gpushup.fish"
echo 'function gdel; git branch -D; end' > "$functions_dir/gdel.fish"
echo 'function gmaster; git move main upstream/main; end' > "$functions_dir/gmaster.fish"
echo 'function gmain; git move main upstream/main; end' > "$functions_dir/gmain.fish"
echo 'function gdev; git move develop upstream/develop; end' > "$functions_dir/gdev.fish"
echo 'function gmove; git branch -f; end' > "$functions_dir/gmove.fish"
