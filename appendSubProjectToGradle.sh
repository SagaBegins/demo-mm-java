#!/bin/bash

prevDir=$(pwd)
projectPath=$1

while (( $# ))
do 
    case $1 in
        -p|--path)
            projectPath=$2
            shift
            ;;
        *)
            # Ignore
            ;;
    esac
    shift
done

cd $projectPath

while read -er file
do
    if [[ $file == "./build.gradle" ]]
    then
        continue
    fi

    file=${file/\./}
    file=${file/\/build\.gradle/}
    path=${file//\//:}    

    if [[ `grep  $path settings.gradle` == "" ]]
    then
        echo "path added $path"
        echo "include '$path'" >> ./settings.gradle
    else
        echo "Path not added $path"
    fi
done < <(find . -iname build.gradle)


cd $prevDir
