#!/bin/bash

# Run from base dir of the repo
# Helps comment/uncomment plugin versions in build.gradle files in
# the sub modules in demo1 and demo2 

comment=1

while (( $# ))
do 
    case $1 in
        -u|--uncomment)
            comment=0
            ;;
        *)
            # Skip unknown options
            ;;
    esac
    shift
done

if (( comment ))
then
    while read -er file
    do
        if [[ $file == "./demo/demo2/build.gradle" || $file == "./demo/demo1/build.gradle" ]]
        then
            continue
        fi
        # Could use s|(.*)[^/]{2} (version '[0-9\.]+')|\1 //\2|
        # or s|id (.*)[^/]{2} (version '[0-9\.]+')|\1 //\2| instead
        sed -ri "s|([^/]{2})(version '2.5.4')|\1 //\2|" $file
        sed -ri "s|([^/]{2})(version '1.0.11.RELEASE')|\1 //\2|" $file
        # sed -ri "s|id 'org.springframework.boot //version '2.5.4'|id 'org.springframework.boot' //version '2.5.4'|" $file
        # sed -ri "s|id 'io.spring.dependency-management //version '1.0.11.RELEASE'|id 'io.spring.dependency-management' //version '1.0.11.RELEASE'|" $file
    done < <(find ./demo/demo1 ./demo/demo2 -iname build.gradle)
else
    while read -er file
    do
        if [[ $file == "./demo/demo2/build.gradle" || $file == "./demo/demo1/build.gradle" ]]
        then
            continue
        fi
        sed -ri "s|//(version '2.5.4')|\1|" $file
        sed -ri "s|//(version '1.0.11.RELEASE')|\1|" $file
    done < <(find ./demo/demo1 ./demo/demo2 -iname build.gradle)
fi
