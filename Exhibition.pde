public class Exhibition
{
  private String [][] newReleases;
  private Artifact[] artifacts;
  private PImage [] albumArt;
  private Spotify spotify;
  private float x;
  private float y;

  // default constructor
  Exhibition()
  {
    this.newReleases = new String[9][7];
    this.artifacts = new Artifact[9];
    this.albumArt = new PImage[9];
    this.spotify = new Spotify();
    this.x = 0.0;
    this.y = 0.0;
  }

  public void prepareArtifacts()
  {
    // get last 9 album releases from Spotify
    this.newReleases = this.spotify.newReleases("GB", 9, 0);

    for (int i = 0; i < this.newReleases.length; i++)
    {
      // create an artifact object for each new release
      this.artifacts[i] = new Artifact(this.newReleases[i][0], this.newReleases[i][1], this.newReleases[i][2], this.newReleases[i][3], this.newReleases[i][4], this.newReleases[i][5], this.newReleases[i][6], 0.0, 0.0, true);

      // load album art
      this.albumArt[i] = loadImage(this.artifacts[i].getAlbumArt());

      // set position of artifacts
      this.artifacts[i].setXPos(x);
      this.artifacts[i].setYPos(y);

      // move to next row of images
      if (this.x == 600)
      {
        this.x = 0;
        this.y += 300;
      } else {
        this.x += 300;
      }
    }
  }

  public void displayArtifacts()
  {
    // loop through each artifact
    for (int i = 0; i < this.artifacts.length; i++)
    {
      // if artifact visibility is set to true
      if ((this.artifacts[i].getVisibility()))
      {
        // display album art
        image(this.albumArt[i], this.artifacts[i].getXPos(), this.artifacts[i].getYPos());
      }
    }
  }

  public void mouseClick()
  {
    // loop through each artifact
    for (int i = 0; i < this.artifacts.length; i++)
    { 
      // check if mouse hovers over artifact
      if (this.artifacts[i].mouseOver(mouseX, mouseY))
      {
        // toggle artifact visibility and display text in its place
        this.artifacts[i].setVisibility(false);
        this.artifacts[i].displayText();
        click.loop(0);
      } else {
        // set artifiact visibility to its default
        this.artifacts[i].setVisibility(true);
      }
    }
  }
}
