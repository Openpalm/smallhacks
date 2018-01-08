#!/bin/bash
# @author; Bassel Khatib
# The MIT License (MIT)

nullip="0.0.0.0"

targets=(
'youtube.com'
'boredpanda.com'
'reddit.com'
'facebook.com'
'amazon.de'
'ebay.de'
'dampfdorado.de'
'news.ycombinator.com'
'twitter.com'
)

if [[ ! $1 =~ "on"|"off" ]]; then
    printf "this not the way use of script is\n./deprocrast on|off is\n"
    exit
fi

if [ $1 == "on" ]; then
    if [ -f /etc/hosts.back ]; then
        printf "hosts.back exists, turn off before retoggling\n"
        exit
    fi
    sudo cp /etc/hosts /etc/hosts.back
    sudo cp /etc/hosts ./hosts.back
    for target in ${targets[@]}; do
        echo  "$nullip $target" | sudo tee --append /etc/hosts > /dev/null
        echo  "$nullip www.$target" | sudo tee --append /etc/hosts > /dev/null
    done
    printf "a wise decison, this is\n"
    exit
fi

if [ $1 == "off" ]; then
    if [ -f /etc/hosts.back ]; then
        sudo mv /etc/hosts.back /etc/hosts
        sudo chmod 0644 /etc/hosts
        printf "enterain me like one of your french girls\n"
        exit
    else
        printf "no hosts.back file present\n"
        exit
    fi
fi
