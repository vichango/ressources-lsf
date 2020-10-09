# README

The goal of this project is to help generating the Anki deck I'm using to learn [LSF](https://fr.wikipedia.org/wiki/Langue_des_signes_française).

## Word list management

I keep track of the words I've learnt in a worksheet which I then export to CSV. The format of the CSV file is best for my manual use. The goal of the `regenerate-list.sh` script is to format it so that it can be imported into Anki.

Call the script by specifying the path to the file to transform, the output will be saved in `/vagrant/list/LSF - Signes.csv`:

```shell
$ source regenerate-list.sh -f <path>
```

## Video management

The `resize-encode.sh` script resizes videos in the `/vagrant/videos` folder from and expected `720p` (`*.m4v`) to `240p` (`*.mp4`).
