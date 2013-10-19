Maxim maxim;
AudioPlayer player;var Vec2D = toxi.geom.Vec2D,
    Line2D = toxi.geom.Line2D;

var LETTER_WIDTH = 20;
var LETTER_HEIGHT = 25;
var CIRCLE_RADIUS = 7;
float THRESHOLD = 3;

Letter[] letters, currentLetter;
int currentLetterIndex = 0;
float currentScale;
Vec2D mouseXY;
boolean requireMousePressedInCircleToContinue = false;

void setup() {
  size(400,400); // supress IDE warnings
  size(window.innerWidth, window.innerHeight);
  frameRate(30);
    
  maxim = new Maxim(this);
  player = maxim.loadFile("pencil.wav");
  player.volume(0.4);
  player.setLooping(true);

  createShapes();
  currentLetter = letters[currentLetterIndex];
}

void draw() {
  if(currentLetter.done && (currentLetterIndex+1) < letters.length){
    currentLetterIndex++;
    currentLetter = letters[currentLetterIndex];
    nextState = 0;
    done = false;
  }

  var newWidth = window.innerWidth;
  var newHeight = int(window.innerHeight);
  if(newWidth != width || newHeight != height){
    size(newWidth, newHeight);
  }  
  mouseXY = new Vec2D(mouseX, mouseY);
  currentScale = min(width/LETTER_WIDTH * 0.5, height/LETTER_HEIGHT * 0.5);

//  background(232,35,176);
  background(255);
  
  pushMatrix();
  translate(width/2, height/2);
  scale(currentScale);
  translate(-LETTER_WIDTH/2, -LETTER_HEIGHT/2);
  
  currentLetter.drawIt();
  
  popMatrix();

  currentLetter.trace();  
}

void mouseReleased() {
  requireMousePressedInCircleToContinue = true;
  player.stop();
  player.cue(0);
}

