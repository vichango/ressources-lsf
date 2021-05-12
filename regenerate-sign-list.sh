#!/bin/bash

# Steps:
# 1. Relabel columns.
# 2. Add `lsf_video` column with the video file name (if any).
# 3. Add `fr_sort` column with `fr_mot` in lower case.
# 4. Add level as `tag`.
# 5. Sort on `fr_sort`.
# 6. Remove temporary columns.
mlr --ors lf --csv \
label fr_mot,fr_desc,tags,lsf_video_tmp,lsf_desc,fss,elix,level,added then \
put '$lsf_video_key = "TRUE" == $lsf_video_tmp ? $fr_mot : $lsf_video_tmp' then \
put '$lsf_video = "FALSE" == $lsf_video_key ? "" : ("[sound:" . $lsf_video_key . ".mp4]")' then \
put '$tags = "LSF I" == $level ? ("lsf-1 " . $tags) : $tags' then \
put '$tags = "LSF II" == $level ? ("lsf-2 " . $tags) : $tags' then \
put '$tags = "LSF III" == $level ? ("lsf-3 " . $tags) : $tags' then \
put '$tags = "LSF IV" == $level ? ("lsf-4 " . $tags) : $tags' then \
put '$tags = "FALSE" == $lsf_video_key && "" == $fss && "" == $elix ? ("[manquant] " . $tags) : $tags' then \
put '$fr_sort = tolower($fr_mot)' then \
sort -f fr_sort then \
cut -x -f level,added,lsf_video_tmp,lsf_video_key,fr_sort then \
reorder -f fr_mot,fr_desc,lsf_video,lsf_desc,fss,elix,tags \
list-signs/sources/*.csv > "LSF - Signes (sorted).csv"

# Remove header.
sed '1d' "LSF - Signes (sorted).csv" > "LSF - Signes.csv"

# Remove temporary files.
rm "LSF - Signes (sorted).csv"

mv "LSF - Signes.csv" list-signs/

echo -e "Terminé!"
