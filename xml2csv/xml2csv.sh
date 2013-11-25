#!/bin/sh
#by noark -_,-+
#xml2csv

`$conf2awk.sh awk.conf`

for file in ./*xml
do
    echo 'xml2csv file:' $file
    filename=`echo $file | cut -c3-`
    tmpfilename=`echo $filename'.tmp'`
    tmpfilepath=`echo './'$tmpfilename`

    `cat $file | xargs | sed 's/>[^<]*<\([^\/]\)/>\n<\1/g' | sed 's/\(<[^>]*>[^<]*<\/[^>]*>\)[^<]*\(<.*\)/\1\n\2/g' | sed 's/\(<\/[^>]*>\)[^<]*\(<\/.*\)/\1\n\2/g' > $tmpfilepath`
    for xmlParser in ./*awk
    do
        xmlParser=`echo $xmlParser | cut -c3-`
        OLD_IFS=$OFS
        IFS='.'
        parserNameParts=($xmlParser)
        IFS=$OLD_IFS
        tagname=${parserNameParts[0]}
        tablename=${parserNameParts[1]}
        tablename=${tablename//_/.}
        echo "check tag $tagname for file $tmpfilepath"
        if `grep -q $tagname $tmpfilepath`
        then
            csvfilename=`echo $tablename'.csv'`
            echo "xml2csv parse file $csvfilename for $tagname"
            `cat $tmpfilepath | awk -f $xmlParser >> $csvfilename`
        fi
    done
done
