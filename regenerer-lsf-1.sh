#!/bin/bash

if [[ $# -eq 0 ]] ; then
    echo 'The path to the CSV file is required'
    exit 0
fi

grep ",LSF I," < "$1" > LSF-1.csv

sed '1i\
fr_mot,fr_desc,tags,lsf_desc,fss,elix,level,added,has_lsf_video
' LSF-1.csv > LSF-1-header.csv

mlr --csv \
put '$lsf_video = "TRUE" == $has_lsf_video ? ("[sound:" . $fr_mot . ".mp4]") : ""' then \
put '$sort = tolower($fr_mot)' then \
sort -f sort then \
cut -x -f level,added,has_lsf_video,sort then \
reorder -f fr_mot,fr_desc,lsf_video,lsf_desc,fss,elix,tags LSF-1-header.csv > LSF-1-sorted.csv

sed '1d' LSF-1-sorted.csv > LSF-1.csv

rm LSF-1-header.csv
rm LSF-1-sorted.csv

mv LSF-1.csv listes/
