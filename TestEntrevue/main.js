/**
	This node js code print in a console the top 10 tracks of
	the artists Justin Bieber. 
	
	author: Andy Su
	last modification date : 2016-02-28
*/

var SpotifyWebApi = require('spotify-web-api-node'), util = require('./util.js');
var spotifyApi = new SpotifyWebApi();


util.printTopTracks(spotifyApi);