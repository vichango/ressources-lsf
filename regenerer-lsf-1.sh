#!/bin/bash

grep ",LSF I," < Tout.csv > LSF-1.csv

sed '1i\
fr-mot,fr-desc,tags,lsf-desc,fss,elix,level,added,lsf-video,has-lsf-video
' LSF-1.csv > LSF-1-header.csv

mlr --csv cut -x -f level,added,has-lsf-video then \
reorder -f fr-mot,fr-desc,lsf-video,lsf-desc,fss,elix,tags LSF-1-header.csv > LSF-1-sorted.csv

sed '1d' LSF-1-sorted.csv > LSF-1.csv

rm LSF-1-header.csv
rm LSF-1-sorted.csv

mv LSF-1.csv listes/
