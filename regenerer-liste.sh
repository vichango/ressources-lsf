#!/bin/bash

helpFunction()
{
   echo "Utilisé pour regénérer le fichiers CSV à importer dans le Deck Anki existant."
   echo ""
   echo "Utilisation: $0 -f <nom de fichier>"
   echo -e "\t-f le <nom de fichier> du CSV à utiliser comme base"
   exit 1 # Exit script after printing help.
}

while getopts "f:f" opt # HACK The script doesn't work with a single "f".
do
   case "$opt" in
      f ) filepath="$OPTARG" ;;
      ? ) helpFunction ;; # Print helpFunction in case parameter is non-existent.
   esac
done

# Print helpFunction in case parameters are empty.
if [ -z "$filepath" ]
then
   echo "Le fichier de base est manquant ou vide.";
   helpFunction
fi

# Replace header.
sed '1d' "$filepath" > "LSF - Signes.csv"
sed '1i\
fr_mot,fr_desc,tags,lsf_video_tmp,lsf_desc,fss,elix,level,added
' "LSF - Signes.csv" > "LSF - Signes (header).csv"

# Add the following columns:
# 1. `lsf_video` with the video file name (if any)
# 2. `fr_sort` for case-insensitive sorting
# Add the level to the `tag` column.
# Sort the table.
mlr --csv \
put '$lsf_video_key = "TRUE" == $lsf_video_tmp ? $fr_mot : $lsf_video_tmp' then \
put '$lsf_video = "FALSE" == $lsf_video_key ? "" : ("[sound:" . $lsf_video_key . ".mp4]")' then \
put '$tags = "LSF I" == $level ? ("lsf-1 " . $tags) : $tags' then \
put '$tags = "LSF II" == $level ? ("lsf-2 " . $tags) : $tags' then \
put '$tags = "LSF III" == $level ? ("lsf-3 " . $tags) : $tags' then \
put '$fr_sort = tolower($fr_mot)' then \
sort -f fr_sort then \
cut -x -f level,added,lsf_video_tmp,lsf_video_key,fr_sort then \
reorder -f fr_mot,fr_desc,lsf_video,lsf_desc,fss,elix,tags \
"LSF - Signes (header).csv" > "LSF - Signes (sorted).csv"

# Remove header.

sed '1d' "LSF - Signes (sorted).csv" > "LSF - Signes.csv"

rm "LSF - Signes (header).csv"
rm "LSF - Signes (sorted).csv"

mv "LSF - Signes.csv" listes/

echo -e "Terminé!"
