package cgi.spotify.test;

import java.util.List;

import com.wrapper.spotify.methods.ArtistRequest;
import com.wrapper.spotify.methods.TopTracksRequest;
import com.wrapper.spotify.models.Track;

/**
 * Application to get the top tracks of an artist using the Spotify API.
 * @author Vincent
 */
public class Application {
	
	// Configuration
	// Change ARTIST_ID to get the top tracks of any other artist.
	private final static String ARTIST_ID = "21mKp7DqtSNHhCAU2ugvUw"; // Artist : ODESZA
	private final static String COUNTRY_CODE = "CA"; 
	private final static String RETRIEVING_ERROR_MESSAGE = "Problem when retrieving ";
	
	/**
	 * Get the top tracks of an artist.
	 * @return Top tracks of an artist.
	 */
	private List<Track> getTopTracks() {
		List<Track> topTracks = null;
		
		// Create a request
		TopTracksRequest request = SpotifyApi.API.getTopTracksForArtist(ARTIST_ID, COUNTRY_CODE).build();
		
		// Retrieve the top tracks of the artist
		try {
			topTracks = request.get();
		} catch (Exception e) {
			System.out.println(RETRIEVING_ERROR_MESSAGE + "top tracks.");
		}
		
		return topTracks;
	}
	
	/**
	 * Get the name of an artist.
	 * @return Name of an artist.
	 */
	private String getArtistName() {
		String artistName = "";
		
		// Create a request
		ArtistRequest request = SpotifyApi.API.getArtist(ARTIST_ID).build();
		
		// Retrieve the artist name
		try {
			artistName = request.get().getName();
		} catch (Exception e){
			System.out.println(RETRIEVING_ERROR_MESSAGE + "artist name.");
		}
		
		return artistName;
	}
	
	/**
	 * Build a customized string of the top tracks.
	 * @param topTracks
	 * @return Customized string of the top tracks.
	 */
	private String textTopTracks(List<Track> topTracks) {
		StringBuilder sb = new StringBuilder();
		if (topTracks != null) {
			// Build the text
			sb.append("Current top tracks for artist : " + getArtistName() + "\n");
			sb.append("--------------------------------" + new String(new char[getArtistName().length()]).replace('\0', '-') + "\n");
			
			int i = 0;
			for (Track t : topTracks) {
				i++;
				sb.append(i + ") " + t.getAlbum().getName() + " - " + t.getName() + "\n");
			}
		} else {
			sb.append("No top tracks were returned.");
		}
		return sb.toString();
	}
	
	/**
	 * Print the top tracks.
	 */
	public void printTopTracks() {
		System.out.println(textTopTracks(getTopTracks()));
	}
}