#!/bin/bash
# $2 dest
# $1 filetype
# todo: pipe output into file. open file with editor. edit
# file to add/remove files from list   .

curl $2  |
grep $2 |
sed -n 's/.*href="\([^"]*\).*/\1/p' |
xargs -n 1 curl -O


