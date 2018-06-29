#!/bin/bash

editor=/usr/local/bin/nvim

function review {
    output="$(arc lint --output compiler)"
    if [ -z "$output" ] || [ "$output" = "No paths are lintable." ];
    then
        echo No lint errors. Running \`arc diff\`...
        arc diff "$@"
        return
    else
        $editor -q <(echo "$output") -c "cwindow | cc"
        review "$@"
    fi
}

review "$@"
