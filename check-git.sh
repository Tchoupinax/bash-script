#!/bin/bash

linux=true
if [ $(uname) == 'Darwin' ];then
    linux=false
fi

for dir in `find ~/Documents -maxdepth 1 -type d`
do 
    # Check if directory is a git project
    if [ -d "${dir}/.git" ]; then
        # Taking name
        name=`echo ${dir} | cut -d '/' -f 5`
        # Going to this repo and ckeck git status
        cd ${dir}
        res=`git status --porcelain`
        # if res is empty, all is clean with git
        if [ "$res" == "" ]; then
            if [ "$1" == "pull" ]; then
                git pull
            fi
            if $linux; then
                echo -e "  \e[92m\e[0m\e[94m ${name}\e[0m"
            else
                echo $'  \e[92m''' $'\e[94m'$name $'\e[0m'
            fi
        else
            if $linux; then
                echo -e "  \e[91m\e[0m\e[94m ${name}\e[0m"
            else
                echo $'  \e[91m''' $'\e[94m'$name $'\e[0m'
            fi
        fi
    fi
done