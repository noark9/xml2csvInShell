#!/bin/sh
#by noark -_,-+
#parse configure file

countOfScripts=0
cat $1 | while read line
do
    aline=`echo ${line/#\#*/}`
    length=`echo ${#aline}`
    if [ $length != 0 ]
    then
        countOfScripts=$(($countOfScripts+1))
        OLD_IFS=$IFS
        IFS=':'
        inputs=($aline)
        IFS=$OLD_IFS
        filename=${inputs[1]}'.'${inputs[2]}'.'$countOfScripts'.awk'
        `echo $aline | awk -f $exepath/conf2awk.awk > $datapath/$filename`
    fi
done
