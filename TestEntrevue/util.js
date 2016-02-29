/**
 * Utility file
 * 
 * author: Andy Su
 * last modification date : 2016-02-28
 */
var config = require("./config.js");

var util = {};

util.printTopTracks = function(spotifyApi) {
	spotifyApi.getArtistTopTracks(config.artist_id, config.country_code).then(
			function(data) {

				if (data.body.tracks[0].name.length !== 0) {
					console.log(config.header);
					for (var i = 0; i < config.number_top_track; i++) {
						var trackPosition = i + 1;
						var trackTitle = data.body.tracks[i].name;
						var albumTitle = data.body.tracks[i].album.name;
						console.log(trackPosition + ")", albumTitle + " - "+ trackTitle);
					}
				}
			}, function(err) {
				console.log(config.error_message, err);
			});

};

module.exports = util;
