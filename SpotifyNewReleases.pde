import ddf.minim.*;
AudioPlayer click;
Minim minim;

Exhibition exhibition;

PFont montserratMedium;

void setup()
{
  size(900, 900);
  noStroke();

  exhibition = new Exhibition();
  exhibition.prepareArtifacts();

  montserratMedium = loadFont("font/Montserrat-Medium-16.vlw");
  textFont(montserratMedium, 16);
  
  minim = new Minim(this);
  click = minim.loadFile("sfx/click.wav");
}

void draw()
{
  exhibition.displayArtifacts();
}

void mousePressed()
{
  exhibition.mouseClick();
}
