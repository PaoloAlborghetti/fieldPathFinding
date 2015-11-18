/* 
 //--------------------------------------------------//----------------------------------------------------//
 
 Some example created with this code : https://vimeo.com/45254455.
 More info at : http://radical-reaction-ad.blogspot.it/
 
 References : 
 -Field class from Daniel Shiffman.
 
 code by Paolo Alborghetti 2013 (cc)Attribution-ShareAlike
 
 ENJOY! :)
 */
import toxi.geom.*;
import controlP5.*;

//------------------------------------------------DECLARE

int popu = 20000;   // agent population
FlowField flowfield;
ArrayList<Agent> agents;

boolean debug = false;
boolean tailPrev=false;
boolean appWander = false;
boolean futPrev = false;
boolean expTiff = false;
boolean NL=true;
boolean fade = true;
int vidcount;
int fcount;

ControlP5 controlP5;
ControlWindow controlWindow;

void setup() {
  size(1280, 720, P2D);
  smooth();

  //--------------------------------------------UI CONTROLS

  initController();
  ui();

  //--------------------------------------------INITIALIZE
  flowfield = new FlowField(2);
  agents = new ArrayList<Agent>();

  for (int i = 0; i < popu; i++) {
    Vec3D origin = new Vec3D (random(width), random(height), 0);
    agents.add(new Agent(origin));
  }
}

void draw() {
  if (!fade) {
    fill(0); //230
    rect(0, 0, width, height);
  } else {
    fill(0, 10);
    rect(0, 0, width, height);
  }

  if (debug) flowfield.display();
  for (Agent v : agents) {
    v.FutLoc();
    v.follow(flowfield);
    v.run();
    v.deposit(flowfield);
    if (appWander) v.wander();
  }
  
  println(int(frameRate));
}

//-------------------------------------------------------------PREVIEW MODE OPTIONS

void keyPressed() {
  if (key == 'c' || key == 'C') {
    flowfield.init();
  }
  if (key == 'd' || key == 'D') {
    debug = !debug;
  }
  if (key == 't' || key == 'T') {
    tailPrev=!tailPrev;
  }
  if (key == 'l'|| key == 'L') {
    fade=!fade;
  }
  if (key == 'w'|| key == 'W') {
    appWander=!appWander;
  }
  if (key == 'f'|| key == 'F') {
    futPrev=!futPrev;
  }
  if (key == 'e'|| key == 'E') {
    tiffImg();
  }
  if (key == 'n'|| key == 'N') {
    NL=!NL;
    if (!NL)noLoop();
    if (NL)loop();
  }
}
void tiffImg() {
  println(frameCount);
  saveFrame("data/####.jpg");
}

