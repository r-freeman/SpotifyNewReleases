public class Artifact
{
  private String albumArt;
  private String artistName;
  private String artistId;
  private String albumName;
  private String releaseDate;
  private String albumId;
  private String genre;
  private float xPos;
  private float yPos;
  private boolean isVisible;

  // default constructor
  Artifact()
  {
    this.albumArt = "";
    this.artistName = "";
    this.artistId = "";
    this.albumName = "";
    this.releaseDate = "";
    this.albumId = "";
    this.genre = "";
    this.xPos = 0.0;
    this.yPos = 0.0;
    this.isVisible = true;
  }

  // constructor with parameters
  Artifact(String albumArt, String artistName, String artistId, String albumName, String releaseDate, String albumId, String genre, Float xPos, Float yPos, Boolean isVisible)
  {
    this.albumArt = albumArt;
    this.artistName = artistName;
    this.artistId = artistId;
    this.albumName = albumName;
    this.releaseDate = releaseDate;
    this.albumId = albumId;
    this.genre = genre;
    this.xPos = xPos;
    this.yPos = yPos;
    this.isVisible = isVisible;
  }

  // detects if mouse hovers over artifact
  public boolean mouseOver(float mouseX, float mouseY)
  {
    if (mouseX >= this.xPos && mouseX <= this.xPos + 295 && mouseY >= this.yPos && mouseY <= this.yPos + 295)
    {
      return true;
    }

    return false;
  }

  // displays text when album art is hidden
  public void displayText()
  {
    fill(29, 185, 84);
    rect(this.xPos, this.yPos, 300, 300);
    fill(255);
    text(this.albumName, this.xPos + 20, this.yPos + 150);
    text(this.artistName, this.xPos + 20, this.yPos + 175);
    text(this.releaseDate, this.xPos + 20, this.yPos + 200);
    text(this.genre, this.xPos + 20, this.yPos + 225);
  }

  // get and set methods
  public void setAlbumArt(String albumArt)
  {
    this.albumArt = albumArt;
  }

  public String getAlbumArt()
  {
    return this.albumArt;
  }

  public void setArtistName(String artistName)
  {
    this.artistName = artistName;
  }

  public String getArtistName()
  {
    return this.artistName;
  }

  public void setArtistId(String artistId)
  {
    this.artistId = artistId;
  }

  public String getArtistId()
  {
    return this.artistId;
  }

  public void setAlbumName(String albumName) {
    this.albumName = albumName;
  }

  public String getAlbumName()
  {
    return this.albumName;
  }

  public void setReleaseDate(String releaseDate)
  {
    this.releaseDate = releaseDate;
  }

  public String getReleaseDate()
  {
    return this.releaseDate;
  }

  public void setAlbumId(String albumId)
  {
    this.albumId = albumId;
  }

  public String getAlbumId()
  {
    return this.albumId;
  }

  public void setGenre(String genre)
  {
    this.genre = genre;
  }

  public String getGenre()
  {
    return this.genre;
  }

  public void setXPos(Float xPos)
  {
    this.xPos = xPos;
  }

  public Float getXPos()
  {
    return this.xPos;
  }

  public void setYPos(Float yPos)
  {
    this.yPos = yPos;
  }

  public float getYPos()
  {
    return this.yPos;
  }

  public void setVisibility(boolean isVisible)
  {
    this.isVisible = isVisible;
  }

  public boolean getVisibility()
  {
    return this.isVisible;
  }
}
