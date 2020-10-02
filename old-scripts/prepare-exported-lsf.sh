#!/bin/bash

helpFunction()
{
   echo "Utilisé pour préparer des nouveaux mots (exportés depuis Anki) à copier coller dans la liste générale."
   echo ""
   echo "Utilisation: $0 -f <nom de fichier> -d <date d'ajout> -l <niveau>"
   echo -e "\t-f le <nom de fichier> du CSV à préparer"
   echo -e "\t-d la <date d'ajout> au format jj/mm/aaaa"
   echo -e "\t-l le <niveau>, pour l'instant soit LSF I, soit LSF II"
   exit 1 # Exit script after printing help
}

while getopts "f:d:l:" opt
do
   case "$opt" in
      f ) filepath="$OPTARG" ;;
      d ) datestr="$OPTARG" ;;
      l ) levelstr="$OPTARG" ;;
      ? ) helpFunction ;; # Print helpFunction in case parameter is non-existent
   esac
done

# Print helpFunction in case parameters are empty
if [ -z "$filepath" ] || [ -z "$datestr" ] || [ -z "$levelstr" ]
then
   echo "Quelques paramètres, ou tous, sont manquants ou vides.";
   helpFunction
fi

sed '1i\
fr_mot,fr_desc,lsf_video,lsf_desc,fss,elix,tags
' "$filepath" > LSF-header.csv

completeCommand="mlr --csv \
put '\$added = \"$datestr\"' then \
put '\$level = \"$levelstr\"' then \
put '\$has_lsf_video = is_empty(\$lsf_video) ? \"FALSE\" : \"TRUE\"' then \
cut -x -f lsf_vide then \
reorder -f fr_mot,fr_desc,tags,has_lsf_video,lsf_desc,fss,elix,level,added \
LSF-header.csv > LSF-sorted.csv"

eval $completeCommand

sed '1d' LSF-sorted.csv > LSF-ready.csv

rm LSF-header.csv
rm LSF-sorted.csv

echo -e "Terminé!"
