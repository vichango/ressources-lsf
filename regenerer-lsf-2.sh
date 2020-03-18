#!/bin/bash

grep ",LSF II," < Tout.csv > LSF-2.csv

sed '1i\
fr-mot,fr-desc,tags,lsf-desc,fss,elix,level,added,lsf-video,has-lsf-video
' LSF-2.csv > LSF-2-header.csv

mlr --csv cut -x -f level,added,has-lsf-video then \
reorder -f fr-mot,fr-desc,lsf-video,lsf-desc,fss,elix,tags LSF-2-header.csv > LSF-2-sorted.csv

sed '1d' LSF-2-sorted.csv > LSF-2.csv

rm LSF-2-header.csv
rm LSF-2-sorted.csv

mv LSF-2.csv listes/
