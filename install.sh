#!/bin/sh

mkdir -p $HOME/.config/cmus
ln -sf $PWD/other/cmusrc $HOME/.config/cmus/rc

cd home
for f in .*; do
    if [ $f != . ] \
            && [ $f != .. ] \
            && [ $f != .git ] \
            && [ $f != .gitignore ]; then
        ln -sf $PWD/$f $HOME
    fi
done
