import javax.xml.bind.DatatypeConverter;
import http.requests.*;

public class Spotify 
{
  // attributes for connecting to Spotify web API
  private JSONObject config;
  private String baseUrl;
  private String authUrl;
  private String clientId;
  private String clientSecret;
  private String authorisationHeader;
  private String refreshToken;
  private String accessToken;

  // default constructor
  // loads configuration data from config.json
  Spotify()
  {
    this.config = loadJSONObject(sketchPath("config.json"));
    this.baseUrl = config.getString("baseUrl");
    this.authUrl = config.getString("authUrl");
    this.clientId = config.getString("clientId");
    this.clientSecret = config.getString("clientSecret");
    this.authorisationHeader = this.clientId + ":" + this.clientSecret;
    this.authorisationHeader = DatatypeConverter.printBase64Binary(this.authorisationHeader.getBytes());
    
    // refresh token allows us to request a new access token
    this.refreshToken = config.getString("refreshToken");
    
    // access token is needed for every request made to spotify
    this.accessToken = this.getAccessToken();
  }

  // access token expires every hour
  // request a new one every time this program is run
  private String getAccessToken()
  {
    PostRequest post = new PostRequest(this.authUrl);
    post.addHeader("Authorization", "Basic " + this.authorisationHeader);
    post.addHeader("Content-Type", "application/x-www-form-urlencoded");

    post.addData("grant_type", "refresh_token");
    post.addData("refresh_token", this.refreshToken);
    post.send();

    JSONObject response = parseJSONObject(post.getContent());
    return response.getString("access_token");
  }

  // returns a two dimensional array of new album releases from Spotify
  // takes three parameters country, limit and offset
  public String [][] newReleases(String country, int limit, int offset)
  {
    String endpoint = this.baseUrl + "/v1/browse/new-releases?country=" + country + "&limit=" + limit + "&offset=" + offset;
    GetRequest get = new GetRequest(endpoint);
    get.addHeader("Authorization", "Bearer " + this.accessToken);
    get.addHeader("Accept", "application/json");
    get.send();

    JSONObject response = parseJSONObject(get.getContent());
    JSONObject albums = response.getJSONObject("albums");
    JSONArray items = albums.getJSONArray("items");

    // initialise new releases string array
    // each new release has seven properties that we want
    String [][] newReleases = new String[9][7];

    // loop through json data returned from spotify
    for (int i = 0; i < items.size(); i++)
    {
      JSONObject item = items.getJSONObject(i);
      JSONArray images = item.getJSONArray("images");

      for (int j = 0; j < images.size(); j++)
      {
        // grab the 300x300 image only
        if (j == 1)
        {
          JSONObject image = images.getJSONObject(j);
          newReleases[i][0] = image.getString("url"); // image url
        }
      }

      JSONArray artists = item.getJSONArray("artists");

      for (int j = 0; j < artists.size(); j++)
      {
        JSONObject artist = artists.getJSONObject(j);
        newReleases[i][1] = artist.getString("name"); // artist name
        newReleases[i][2] = artist.getString("id"); // artist id
      }

      newReleases[i][3] = item.getString("name"); // album name
      newReleases[i][4] = item.getString("release_date"); // release date
      newReleases[i][5] = item.getString("id"); // album id

      // saves album artwork
      this.saveAlbumArt(newReleases[i][0], newReleases[i][5]);
      newReleases[i][0] = dataPath(newReleases[i][5] + ".jpg");

      // set genre
      newReleases[i][6] = this.genre(newReleases[i][2]); // genre
    }

    return newReleases;
  }

  // returns genres for a given artist id
  private String genre(String artistId)
  {
    String endpoint = this.baseUrl + "/v1/artists/" + artistId;
    String genre = "";

    GetRequest get = new GetRequest(endpoint);
    get.addHeader("Authorization", "Bearer " + this.accessToken);
    get.addHeader("Accept", "application/json");
    get.send();

    JSONObject response = parseJSONObject(get.getContent());
    JSONArray genres = response.getJSONArray("genres");

    // sometimes genres is an empty array
    if (genres.size() == 0)
    {
      // set genre to nothing if this is the case
      genre = "";
    } else {
      for (int i = 0; i < genres.size(); i++)
      {
        // grab the primary genre of artist only
        genre = genres.get(0).toString();
      }
    }

    return genre;
  }

  // retrieve album artwork and save
  private void saveAlbumArt(String url, String albumId)
  {
    String path = dataPath(albumId + ".jpg");

    if (!(this.albumArtExists(path)))
    {
      byte b [] = loadBytes(url);
      saveBytes(path, b);
    }
  }

  // checks if album art already exists
  private boolean albumArtExists(String path)
  {
    File albumArt = new File(path);
    while (albumArt.exists())
    {
      return true;
    }

    return false;
  }
}
