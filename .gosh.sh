#!/usr/bin/env bash

# Default a variable named $1 to $2 unless already set.
# This is more readable than expansion syntax.
# E.g.,
#    default foo bar
# vice:
#    export FOO="${FOO:=$BAR}"
function default {
    if [ $# -ne 2 ]; then
        echo "usage: default <variable> <default value>"
        echo "(got: $@)"
        exit 1
    fi
    eval __=\$$1
    if [ -z "$__" ]; then
        export $1="$2"
    fi
}

# Returns 1 if the environment variable $1 is not set, 0 otherwise.
# E.g.,
#    assert_env PATH
function assert_env {
    if [ $# -ne 1 ]; then
        echo "usage: assert_env <variable>"
        echo "(got: $@)"
        exit 1
    fi
    eval __=\$$1
    if [ -z "$__" ]; then
        echo "$1 is not set" 1>&2
        return 1
    fi
    return 0
}

# Prompts the user to set a variable if it does not have a default value.
# E.g.,
#    prompt_env VERSION "VERSION is not set, please set it now: "
function prompt_env {
    if [ $# -ne 2 ]; then
        echo "usage: prompt_env <variable> <prompt>"
        echo "(got: $@)"
        exit 1
    fi
    eval __=\$$1
    if [ -z "$__" ]; then
        read -p "$2" REPLY
        if [ -z "$REPLY" ]; then
            echo "noo response" 1>&2
            return 1
        fi
        export $1="$REPLY"
    fi
    return 0
}

