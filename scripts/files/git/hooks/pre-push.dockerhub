#!/bin/bash

remote="$1"
url="$2"

z40=0000000000000000000000000000000000000000

while read local_ref local_sha remote_ref remote_sha
do
    if [ "$local_sha" = $z40 ]
    then
        # Handle delete
        :
    else
        if [ "$remote_sha" = $z40 ]
        then
            # New branch, examine all commits
            range="$local_sha"
        else
            # Update to existing branch, examine new commits
            range="$remote_sha..$local_sha"
        fi

        # Check for changes in "devcontainers/" directory
        commit=$(git diff --name-only "$range" | grep "^devcontainers/")

        if [ -n "$commit" ]; then
            # We have changes in "devcontainers/" directory
            for dir in $(git diff --name-only "$range" | grep "^devcontainers/" | cut -d/ -f2 | uniq); do
                echo "Changes found in devcontainers/$dir..."
                docker build -t recrash/$dir:latest devcontainers/$dir
                docker push recrash/$dir:latest
            done
        fi
    fi
done

exit 0
