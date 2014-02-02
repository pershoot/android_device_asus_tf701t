#!/bin/sh

BASE=../../../vendor/asus/tf701t/proprietary
rm -rf $BASE/*

for FILE in `cat proprietary-files.txt`; do
    DIR=`dirname $FILE`
    if [ ! -d $BASE/$DIR ]; then
        mkdir -p $BASE/$DIR
    fi
    adb pull /system/$FILE $BASE/$FILE
done

if [ -d $BASE/lib/python2.6 ]; then
   (cd $BASE/lib && tar czf python2.6.tar.gz python2.6 && rm -rf python2.6)
fi

./setup-makefiles.sh
