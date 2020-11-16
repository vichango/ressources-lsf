#!/bin/bash

# Steps:
# 1. Relabel columns.
# 2. Add an `id` column with a computed ID.
# 3. Sort the table.
mlr --ors lf --csv \
label lid,pid,phrase,lsf,commentaire,source,tags,date then \
put '$id = "phrase-" . (10 > $lid ? "0" : "") . $lid . "-" . (10 > $pid ? "0" : "") . $pid' then \
sort -f id then \
cut -x -f lid,pid,date then \
reorder -f id,phrase,lsf,commentaire,source,tags \
list-phrases/sources/*.csv > "LSF - Phrases (sorted).csv"

# Remove header.
sed '1d' "LSF - Phrases (sorted).csv" > "LSF - Phrases.csv"

# Remove temporary files.
rm "LSF - Phrases (sorted).csv"

mv "LSF - Phrases.csv" list-phrases/

echo -e "Terminé!"
