#!/bin/sh

readonly PWD=$(pwd)

for f in .*; do
    if [ $f != . ] \
            && [ $f != .. ] \
            && [ $f != .git ] \
            && [ $f != .gitignore ]; then
        ln -sf $PWD/$f $HOME
    fi
done
