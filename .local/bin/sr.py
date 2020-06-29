#!/usr/bin/python

import os
import sys
import getopt
from pytvdbapi import api

def main(argv):
    inputfile = ''

    opts, args = getopt.getopt(argv, "hi:p:s:e:l:a:o:", ["ifile=", "program=", "season=", "episode=", "leadingepisode=", "absolute=", "lang=",])

    showsearch = ''
    seasonnumber = ''
    episodenumber = ''
    absolute = ''
    lang = 'en'

    le = 2

    for opt, arg in opts:
        if opt == '-h':
            print('sr.py -i <inputfile>')
            sys.exit()
        elif opt in ("-i", "--ifile"):
            inputfile = arg
        elif opt in ("-p", "--progam"):
            showsearch = arg
        elif opt in ("-s", "--season"):
            seasonnumber = int(arg)
        elif opt in ("-e", "--episode"):
            episodenumber = int(arg)
        elif opt in ("-l", "--leadingepisode"):
            le = int(arg)
        elif opt in ("-a", "--absolute"):
            absolute = int(arg)
        elif opt in ("-o", "--lang"):
            lang = arg

    if not os.path.isfile(inputfile):
        sys.exit("The input is not a file")

    db = api.TVDB("B43FF87DE395DF56")

    if not showsearch:
        showsearch = input("show: ")

    shows = db.search(showsearch, lang)

    show = shows[0]

    print(show.SeriesName)

    if absolute:
        episode = db.get_episode(lang, "absolute", absolutenumber=absolute, seriesid=show.seriesid)
        season = show[episode.SeasonNumber]
    else:
        if not seasonnumber:
            for season in show:
                print(season.season_number)
            seasonnumber = input("seasson: ")

        season = show[int(seasonnumber)]

        if not episodenumber:
            for episode in season:
                print(episode.EpisodeNumber, episode.EpisodeName)

            episodenumber = input("episode: ")

        episode = season[int(episodenumber)]

    print(episode.EpisodeName)
    filename, fileextension = os.path.splitext(inputfile)

    newfilename = "S{0} E{1} - {2}{3}".format(str(season.season_number).zfill(2), str(episode.EpisodeNumber).zfill(le) ,episode.EpisodeName, fileextension)
    print(newfilename)

    directory = "/mnt/megastorage/Media/Series/{0}".format(show.SeriesName)
    print(directory)
    if not os.path.exists(directory):
        os.makedirs(directory)
    newfile = os.path.join(directory, newfilename)

    if os.path.isfile(newfile):
        sys.exit("the destination file already exists")

    os.rename(inputfile, newfile)

if __name__ == "__main__":
    main(sys.argv[1:])
