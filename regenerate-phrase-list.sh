#!/bin/bash

helpFunction()
{
   echo "Regenerate CSV Signs file to import in an existing Anki deck."
   echo ""
   echo "Usage: $0 -f <file-name>"
   echo -e "\t-f the <file-name> of the base CSV file."
   exit 1 # Exit script after printing help.
}

while getopts "f:f" opt # HACK Iterate from "f" to "f" because a single "f" doesn't work.
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
sed '1d' "$filepath" > "LSF - Phrases.csv"
sed '1i\
lid,pid,phrase,lsf,commentaire,source,tags,date
' "LSF - Phrases.csv" > "LSF - Phrases (header).csv"

# Add the following columns:
# 1. `id` with the phrase full ID
# Sort the table.
mlr --csv \
put '$id = "phrase-" . (10 > $lid ? "0" : "") . $lid . "-" . (10 > $pid ? "0" : "") . $pid' then \
sort -f id then \
cut -x -f lid,pid,date then \
reorder -f id,phrase,lsf,commentaire,source,tags \
"LSF - Phrases (header).csv" > "LSF - Phrases (sorted).csv"

# Remove header.
sed '1d' "LSF - Phrases (sorted).csv" > "LSF - Phrases.csv"

# Remove temporary files.
rm "LSF - Phrases (header).csv"
rm "LSF - Phrases (sorted).csv"

mv "LSF - Phrases.csv" /vagrant/list/

echo -e "Terminé!"
