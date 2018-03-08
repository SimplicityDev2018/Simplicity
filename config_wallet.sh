#!/bin/bash
folder=~/.simplicity/
file=~/.simplicity/masternode.conf
file2=~/.simplicity/simplicity.conf

if [ ! -d $folder ]
then
        echo "$folder doesn't exist"
        mkdir $folder
fi

if [ -e $file ]
then
        echo "$file exist, I delet it"
        rm $file
fi
if [ -e $file2 ]
then
        echo "$file2 exist, I delet it"
        rm $file2
fi

read -p 'masternode name: ' name
read -p 'your masternode genkey (Step1): ' genkey
read -p 'your masternode output (step4): ' output
read -p 'id (number adter the long line in step 4): ' id
#read -p 'your ip: ' ip

function password
{
date +%s | sha256sum | base64 | head -c 32
}

function ip
{
wget http://checkip.dyndns.org -O - -o /dev/null | cut -d : -f 2 | cut -d \< -f$
}


echo -e "$name `ip`:9999 $genkey $output $id" >> $file
echo -e "rpcuser=rpcuser
rpcpassword= `password`
rpcport=11958
port=9999
deamon=1
server=1
listen=1
staking=0
maxconnections=32
masternode=1
masternodeaddre=`ip`:9999
masternodeprivkey=$genkey" >> $file2

echo $pwd >> $file2

echo -e "\n"
echo "your $file:"
cat $file

echo -e '\n'

echo "your $file2:"
cat $file2
