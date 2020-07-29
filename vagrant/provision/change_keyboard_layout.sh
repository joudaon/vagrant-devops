#!/bin/bash -eu

# https://stackoverflow.com/questions/12545066/shell-script-to-check-ubuntu-version-and-then-copy-files/12545127

# update keyboard configuration file with spanish keyboard layout
echo "-------------------------------------------------------------"
echo "-------> Starting 'change_keyboard_layout.sh' script <-------"
echo "-------------------------------------------------------------"
echo "=======> Changing keyboard layout"

echo "Displaying /etc/default/keyboard before changes: "
echo "-------------------------------------------------"
cat /etc/default/keyboard

sed -i 's/XKBMODEL="SKIP"/XKBMODEL="pc105"/' /etc/default/keyboard

if [[ `lsb_release -rs` == "18.04" ]]
then
sed -i 's/XKBLAYOUT="us"/XKBLAYOUT="es"/' /etc/default/keyboard
elif [[ `lsb_release -rs` == "16.04" ]]
then
sed -i 's/XKBLAYOUT=""/XKBLAYOUT="es"/' /etc/default/keyboard
fi

echo "Displaying /etc/default/keyboard after changes: "
echo "------------------------------------------------"
cat /etc/default/keyboard
