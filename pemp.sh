#!/bin/bash

# get root directory
while getopts 'd:' OPTION; do
  case "$OPTION" in
    d) cd ${OPTARG};;
    ?) cd ..;;
  esac
done
shift "$(($OPTIND -1))"

# echo "$PWD"

# loop over all projects
for f in */; do
    if [ -f "$f.pemp" ]; then
        pattern=($(cat $f.pemp | awk -v f=$f '{print "-path", f$1, "-o"}'))
        unset 'pattern[-1]'
        echo "${pattern[@]}"
        command="find $f -type d,f,l ( ${pattern[@]} ) -a -delete"
        $($command)
    fi
done

# for f in */; do
#     if [ -f "$f.pemp" ]; then
#         while IFS="" read -r p || [ -n "$p" ]
#         do
#             if [ -d $f$p ]; then
#                 # check that file is in subdir
#                 cd $f$p
#                 if [[ $PWD/ =~ /$f.+ ]]; then
#                     cd $OLDPWD
#                     gio trash $f$p
#                     echo "deleted $f$p"
#                 else
#                     cd $OLDPWD
#                     echo "ignored $f$p"
#                 fi
#             else
#                 echo "skipped $f$p"
#             fi
#         done < $f.pemp
#     fi
# done

