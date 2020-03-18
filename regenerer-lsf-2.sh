#!/bin/bash

if [[ $# -eq 0 ]] ; then
    echo 'The path to the CSV file is required'
    exit 0
fi

grep ",LSF II," < "$1" > LSF-2.csv

sed '1i\
fr_mot,fr_desc,tags,has_lsf_video,lsf_desc,fss,elix,level,added
' LSF-2.csv > LSF-2-header.csv

mlr --csv \
put '$lsf_video = "TRUE" == $has_lsf_video ? ("[sound:" . $fr_mot . ".mp4]") : ""' then \
put '$fr_sort = tolower($fr_mot)' then \
sort -f fr_sort then \
cut -x -f level,added,has_lsf_video,fr_sort then \
reorder -f fr_mot,fr_desc,lsf_video,lsf_desc,fss,elix,tags LSF-2-header.csv > LSF-2-sorted.csv

sed '1d' LSF-2-sorted.csv > LSF-2.csv

rm LSF-2-header.csv
rm LSF-2-sorted.csv

mv LSF-2.csv listes/
