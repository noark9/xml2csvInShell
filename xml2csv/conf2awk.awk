/.*/ {
    input=$0
    gsub(/#.*/,"",input)
    if (length(input)>0)
    {
        inputCount=split(input,inputs,":")
        columnCount=split(inputs[4],columns,",")
        lineCondition=""
        headerCondition=""
        lastline=""
        countOfConst=0
        lineCondition="%s {if(NEEDPROCESS"inputs[2] inputs[3]" == 1){%s}}\n";
        headerCondition="%s {NEEDPROCESS"inputs[2] inputs[3]"=1;%s}\n";
        if(length(inputs[1])>0)
        {
            lastline="/<\\/"inputs[2]">/ {if(("inputs[1]") && NEEDPROCESS"inputs[2] inputs[3]" == 1){print "
        }
        else
        {
            lastline="/<\\/"inputs[2]">/ {if(NEEDPROCESS"inputs[2] inputs[3]" == 1){print "
        }
        firstLine=""
        lineFormat="%s=$0;sub(/^[ \\t\\r\\n]+/,\"\",%s);sub(/[ \\t\\r\\n]+$/,\"\",%s);gsub(/<\\/%s>/,\"\",%s);gsub(/<%s.*>/,\"\",%s)"
        lines=""
        lastline=lastline "\"\\\"\" "
        for(i=1;i<=columnCount;i++)
        {
            if (match(columns[i],/[0-9]*\)/))
            {
                continue
            }
            if (match(columns[i],/{.*}/))
            {
                countOfConst++
                lastline=lastline "__constVirable"countOfConst"__"
                firstLine=firstLine "__constVirable"countOfConst"__=\""columns[i]"\";"
                firstLine=firstLine "gsub(/[{}]/,\"\",__constVirable"countOfConst"__);"
            }
            else
            {
                lastlinestr=columns[i]
                if (match(columns[i],/.*\([0-9]*/))
                {
                    columns[i]=columns[i]","columns[i+1]
                    columnstr=columns[i]
                    gsub(/\(.*\)/,"",columns[i])
                    columnstr=substr(columnstr,index(columnstr,"("))
                    gsub(/[\(\)]/,"",columnstr)
                    startIndex=substr(columnstr,1,index(columnstr,",")-1)
                    countOfStr=substr(columnstr,index(columnstr,",")+1)
                    lastlinestr="substr("columns[i]","startIndex","countOfStr")"
                }
                aLine=sprintf(lineFormat, columns[i], columns[i], columns[i], columns[i], columns[i], columns[i], columns[i])
                lines=lines sprintf(lineCondition, "/<\\/"columns[i]">/", aLine)
                lastline=lastline lastlinestr
                firstLine=firstLine columns[i] "=\"\";"
            }
            if (i<columnCount)
            {
                if((i+1>=columnCount) && match(columns[i+1],/[0-9]*\)/))
                {
                    lastline=lastline
                }
                else
                {
                    lastline=lastline " \"\\\",\\\"\" "
                }
            }
        }
        header="/<" inputs[2] ".*>/"
        printf(headerCondition, header, firstLine)
        printf("%s", lines)
        print lastline " \"\\\"\"}}"
    }
}

