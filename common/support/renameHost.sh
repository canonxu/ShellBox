#/bin/bash

# Function: rename the name for server
# Example: bash renameHost.sh aliyun
# Tip: only tested for Debian

if [ $# -ne 1 ]; then
    echo "Exactly one param as hostname is required..."
    exit -1
fi

old_name=`cat /etc/hostname`
new_name=$1

echo "Change hostname from $old_name(old) to $new_name(new)..."

echo $new_name > /etc/hostname
/etc/init.d/hostname.sh start
head -1 /etc/hosts | grep -wq $old_name
if [ $? -eq 0 ]; then
    sed -i "1s/\s\<$old_name\>//g" /etc/hosts
fi
sed -i "1s/$/ $new_name/" /etc/hosts

echo -n "System need reboot to rename the host, are you sure to reboot now(y/n)?"
read answer
echo $answer | grep -iq "^y"
if [ $? -eq 0 ]; then
    shutdown -r -t 1 now "System will reboot now..."
else
    echo "Remember to reboot the system later!"
fi
