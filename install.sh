#!/bin/sh

if [ ! -d "$HOME/.qutie" ]; then
    echo "Installing Qutie for the first time..."
    git clone https://github.com/jcenturion/qutie.git "$HOME/.qutie"
    cd "$HOME/.qutie"
    [ "$1" == "ask" ] && export ASK="true"
    rake install
else
    echo "Qutie is already installed"
fi
