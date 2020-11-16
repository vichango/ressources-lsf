# README

The goal of this project is to help generating the Anki deck I'm using to learn [LSF](https://fr.wikipedia.org/wiki/Langue_des_signes_française).

## List management

I keep track of the words and phrases I've learnt in multiple worksheet. The goal of the `regenerate-*.sh` scripts is to take a CSV version of those worksheets and refactor them into a single importable file (for Anki).

```sh
# The script will merge all CSV files in list-*/sources
$ source regenerate-<option>-list.sh
```

## Video management

The `resize-encode.sh` script resizes videos in the `/vagrant/videos` folder from and expected `720p` (`*.m4v`) to `240p` (`*.mp4`).
