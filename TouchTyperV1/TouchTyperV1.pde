/* 
Letter touch typing trainer
Ian Loh June 2018  
ianlohjy@hotmail.com
*/

import java.text.DecimalFormat;
private static DecimalFormat df2 = new DecimalFormat("#.###");

int keyCodeRange[] = {65,90}; // This is the ascii range to test on (65=a, 90=z)
int currentKey;
int letterCase;
PFont font;

color stateColor = color(0,0,0);
color stateColorHit = color(0,255,100);
color stateColorMiss = color(255,100,20);
float stateColorLerp = 0;
float stateColorLerpSpeed = 0.05;

// Stats
int mistypes = 0;
int totalLetters = 0;

// Audio
// ...

void settings()
{
  size(512,512);
}

void setup()
{
  font = createFont("Slabo27px-Regular.ttf", 72);
  textFont(font);
  newRandomLetter();
  textSize(128);
}

void draw()
{
  background(0);
  
  stateColorLerp += stateColorLerpSpeed;
  pushStyle();
  noFill();
  stroke(lerpColor(stateColor,color(0,0,0),stateColorLerp));
  strokeWeight(20);
  rect(0,0,width,height);
  popStyle();
  
  fill(200);
  textAlign(CENTER,CENTER);
  
  String letterDisplay = String.valueOf(char(currentKey));
  if(letterCase == 0)
  {  
    letterDisplay = letterDisplay.toLowerCase();
  }
  
  textSize(128);
  text(letterDisplay, width/2, height/2);
  
  String totalLettersText = "Total Letters: " + Integer.toString(totalLetters);
  textSize(18);
  textAlign(LEFT, BOTTOM);
  text(totalLettersText, 20, height-15);
  
  String scoreText = "Score: " + totalLetters + "/" + (mistypes+totalLetters);
  textAlign(CENTER, BOTTOM);
  text(scoreText, width/2, height-15);
  
  float accuracy = (float)totalLetters/(mistypes+totalLetters);
  String accuracyText = "Accuracy: " + df2.format(accuracy);
  textAlign(RIGHT, BOTTOM);
  text(accuracyText, width-20, height-15);
  
}

void keyPressed()
{
  stateColorLerp = 0;
  
  if(keyCode == currentKey)
  {
    // println("You got it!");
    newRandomLetter();
    stateColor = stateColorHit;
  }
  else
  {
    mistypes++;
    stateColor = stateColorMiss;
  }
}

int randomInt(int start, int end)
{
  return int(random((float)start, (float)end+1));
}

void newRandomLetter()
{
  letterCase = randomInt(0,1);
  currentKey = randomInt(keyCodeRange[0], keyCodeRange[1]);
  totalLetters++;
  //println(letterCase);
}
