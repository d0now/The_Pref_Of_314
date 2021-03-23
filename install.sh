#!/bin/bash

SCRIPT_DIR=$(dirname $(realpath $0))

BASHRC="$HOME/.bashrc"
VIMRC="$HOME/.vimrc"
PREF="$HOME/.d0now"

if [ -d "$PREF" ]; then
    cp "$PREF/.original.bashrc" "$BASHRC"
    cp "$PREF/.original.vimrc" "$VIMRC"
    rm -rf "$PREF"
fi

mkdir -m 700 "$PREF"

[ -f "$BASHRC" ] && cp "$BASHRC" "$PREF/.original.bashrc"
[ -f "$VIMRC" ] && cp "$VIMRC" "$PREF/.original.vimrc"

################################################################################
# Bash
################################################################################

# Copy
cp "$SCRIPT_DIR/bash/.PS1.sh" "$PREF/.PS1.sh"

# Setup
cat << EOF >> $BASHRC

#
# d0now's preference - bash
#

source $HOME/.d0now/.PS1.sh

EOF

################################################################################
# VIM
################################################################################

# Copy
cp "$SCRIPT_DIR/vim/.vimrc" "$PREF/.vimrc"

# Setup
cat << EOF >> $VIMRC

"
" d0now's preference - vim
"

source $HOME/.d0now/.vimrc

EOF

################################################################################
# WSL
################################################################################

if [ "$WSL_DISTRO_NAME" ]; then

#
# Copy
#

cp "$SCRIPT_DIR/wsl/.WSL.sh" "$PREF/.WSL.sh"

#
# Setup - bashrc
#

cat << EOF >> $BASHRC

#
# d0now's preference - wsl
#

source $HOME/.d0now/.WSL.sh

EOF

#
# Setup - aliases
#

function Get-AliasPath {
    ORIG=$(pwd)
    cd $SCRIPT_DIR/wsl/.pscripts
    powershell.exe -ExecutionPolicy Bypass ".\\Get-AliasPath.ps1 \"$1\""
    cd $ORIG
}

echo -ne "\n\n# aliases" >> $HOME/.d0now/.WSL.sh

# Vagrant
[ $(Get-AliasPath "vagrant") ] && echo "alias vagrant=$(wslpath $(Get-AliasPath "vagrant"))" >> $HOME/.d0now/.WSL.sh

# Python
[ $(Get-AliasPath "python") ]  && echo "alias win-python=$(wslpath $(Get-AliasPath "python"))" >> $HOME/.d0now/.WSL.sh
[ $(Get-AliasPath "python2") ] && echo "alias win-python2=$(wslpath $(Get-AliasPath "python2"))" >> $HOME/.d0now/.WSL.sh
[ $(Get-AliasPath "python3") ] && echo "alias win-python3=$(wslpath $(Get-AliasPath "python3"))" >> $HOME/.d0now/.WSL.sh
[ $(Get-AliasPath "pip") ]     && echo "alias win-pip=$(wslpath $(Get-AliasPath "pip"))" >> $HOME/.d0now/.WSL.sh
[ $(Get-AliasPath "pip2") ]    && echo "alias win-pip2=$(wslpath $(Get-AliasPath "pip2"))" >> $HOME/.d0now/.WSL.sh
[ $(Get-AliasPath "pip3") ]    && echo "alias win-pip3=$(wslpath $(Get-AliasPath "pip3"))" >> $HOME/.d0now/.WSL.sh

fi

#
# ...
#

echo -ne "\nclear\n" >> $BASHRC