#!/bin/bash
set -u;
md5sum="`md5sum *jpg;`";
ls -1 *jpg | while read file; do
  digest=`exiftool $file | sed -n 's/Image Description.*: \(.*\)$/\1/p';`;
  if [[ -n "$digest" ]]; then
    reference=`md5sum *jpg | sed -n "s/$digest \(.*\)/\1/p";`;
    echo "${file} (`md5sum ${file} | cut -f1 -d' ';`) -> ${reference} (${digest})";
  else
    echo "${file} does not contain an digest into exif";
  fi;
done;
