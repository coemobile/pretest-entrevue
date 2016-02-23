# Author: Nicolas Cusson
# Description: Application to list the top songs of an artist using Spotify API
# Usage: ruby app.rb <artistId> <countryCode>

# A couple artist ID (just in case we get tired of Justin ...)
# 7jy3rLJdDQY21OgRLCZ9sD => Foo Fighters
# 6mdiAmATAx73kdxrNrnlao => Iron Maiden
# 4S9EykWXhStSc15wEx8QFK => Céline Dion
# 0gxyHStUsqpMadRV0Di1Qt => Rick Astley
# 1uNFoZAHBGtllmzznpCI3s => Justin Bibière

require 'net/http'
require 'resolv-replace.rb'
require 'json'

#Const

#String format
API_URL = "https://api.spotify.com/v1/artists/%s/top-tracks?country=%s" #first param is artistId, seccond param is country code
HEADER = "Current top tracks for artist: %s\n"                          #first param is artist name
SONG_FORMAT = "%d) %s - %s\n"                                                #first param is list count, seccond param is album title, 
                                                                        # third param is song title
#Msg
USAGE = "Usage: ruby app.rb <artistId> <countryCode> \nEx: ruby app.rb 0gxyHStUsqpMadRV0Di1Qt CA"

# Main
def main
    args = parseArgv()
    
    if(args != nil)
        displaySongs(parseResponse(getTopTracks(args[0], args[1])))
    end
end

# Parse command line arguments
def parseArgv()
    if(ARGV.count < 2)
        puts USAGE
        return nil
    end

    artistId = ARGV[0]
    countryCode = ARGV[1]
    
    return [artistId, countryCode]
end

# Fetch the most popular songs from the API
def getTopTracks(artistId, country)
    begin
        url = sprintf(API_URL, artistId, country)
        resp = Net::HTTP.get_response(URI.parse(url)) # get_response takes an URI object
        data = resp.body
    rescue Exception => e
        puts e.message
    end
end

# Parse the response
def parseResponse(data)
    begin
        parsedData = JSON.parse(data);
    rescue Exception => e
        puts e.message
    end
end

# Display the songs
def displaySongs(data)
    begin
        #check if the response contains an error
        if(data['error'])
            return puts data['error']['message']
        end

        tracks = data['tracks']

        # print the header with the main artist name
        firstTrack = tracks.at(0)
        artists = firstTrack['artists']
        printf(HEADER, artists.at(0)['name'])

        printSeparator()

        # print each tracks
        count = 0
        tracks.each { |track| printf(SONG_FORMAT, count+=1,track['album']['name'], track['name']) }
    rescue Exception  => e
        puts e.message
    end
end

def printSeparator
    puts "-" * 50
end

#lauch main
main()