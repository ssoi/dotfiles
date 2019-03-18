#!/bin/bash

set -x

PYTHONLIB=`python -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())"`

TAGSDIR="${HOME}/.vim/tags"
TAGSFILE="${TAGSDIR}/tags"

TAGSTOREMOVELIST=`mktemp`
FILESTOTAGLIST=`mktemp`

get_all_files () {
    find $PYTHONLIB -name "*.py" > $FILESTOTAGLIST
}

find_new_files () {
    find $PYTHONLIB -newer $TAGSFILE -name "*.py" > $TAGSTOREMOVELIST
}

remove_tags () {
    for FILE in `find $PYTHONLIB -newer $TAGSFILE -name "*.py"`
    do
       #RENAMEDFILE=`echo ".${FILE#$PYTHONLIB}" | sed "s/\//\\\\\\\\\//g"`
       RENAMEDFILE=`echo "$FILE" | sed "s/\//\\\\\\\\\//g"`
       sed -i "/$RENAMEDFILE/d" $TAGSFILE
       echo $FILE >> $FILESTOTAGLIST
    done
}

tag_files () {
    cat $FILESTOTAGLIST | xargs ctags -o $TAGSFILE -a --python-kinds=-i
}

clean () {
    rm $FILESTOTAGLIST \
       $TAGSTOREMOVELIST
}

if [[ -f $TAGSFILE ]]
then
    find_new_files
    remove_tags
else
    get_all_files
fi

if [[ -s $FILESTOTAGLIST ]]
then
    tag_files
    clean
fi
