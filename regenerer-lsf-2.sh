#!/bin/bash

helpFunction()
{
   echo "Utilisé pour regénérer le fichier CSV à importer dans le Deck Anki « LSF II - Mots et formules » existant."
   echo ""
   echo "Utilisation: $0 -f <nom de fichier>"
   echo -e "\t-f le <nom de fichier> du CSV à utiliser comme base"
   exit 1 # Exit script after printing help.
}

while getopts "f:f" opt # The script doesn't work with a single "f".
do
   case "$opt" in
      f ) filepath="$OPTARG" ;;
      ? ) helpFunction ;; # Print helpFunction in case parameter is non-existent.
   esac
done

# Print helpFunction in case parameters are empty.
if [ -z "$filepath" ]
then
   echo "Le nom du fichier est manquant ou vide.";
   helpFunction
fi

grep ",LSF II," < "$filepath" > LSF-2.csv

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

echo -e "Terminé!"
