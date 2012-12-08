#!/bin/bash
file=`echo $1 | cut -d"/" -f4`
type=`file -bi $1 | cut -d"/" -f2`
cp $1 /Users/jonathan/tmp/pine.attach/$file.$type
open /Users/jonathan/tmp/pine.attach/$file.$type
