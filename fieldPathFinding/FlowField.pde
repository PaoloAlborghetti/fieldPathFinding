class FlowField {

  //-------------------------------------------------------DECALRE VARIABLES

  Vec3D[][] field;
  int cols, rows; 
  int resolution; 

  //-------------------------------------------------------CONSTRUCTOR

  FlowField(int r) {
    resolution = r;
    cols = width/resolution;
    rows = height/resolution;
    field = new Vec3D[cols][rows];
    init();
  }

  //----------------------------------------------------------------------FUNCTIONS

  void init() {
    noiseSeed((int)random(10000));
    float xoff = 0;
      for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        field[i][j] = new Vec3D(random(-1, 1), random(-1, 1), 0);
      }
    }  
  }

  // -------------------------------------------------------------------DISPLAY

  void display() {
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        //drawVector(field[i][j], i*resolution, j*resolution, 4);
        drawTerrain(field[i][j], i*resolution, j*resolution, i, j);
      }
    }
  }


  // -------------------------------------------------------------------DRAW TERRAIN

  void drawTerrain(Vec3D pher, float x, float y, int i, int j) {
    pushMatrix();
    colorMode(RGB);
    float colR = map(pher.x, 0, maxVel, 0, 255);
    float colG = map(pher.y, 0, maxVel, 0, 255);
    fill(colR, colG, 0);
    noStroke();
    rect(x, y, resolution, resolution);
    popMatrix();
  }


  // -------------------------------------------------------------------DRAW VECTOR

  void drawVector(Vec3D v, float x, float y, float scayl) {
    pushMatrix();
    translate(x, y);
    float colR = map(v.x, 0, maxVel, 0, 255);
    float colG = map(v.y, 0, maxVel, 0, 255);
    stroke(colR, colG, 0);
    strokeWeight(1);
    rotate(v.headingXY());
    float len = v.magnitude()*scayl;
    line(0, 0, len, 0);
    popMatrix();
  }

  // -------------------------------------------------------------------LOOK UP

  Vec3D lookup(Vec3D lookup) {
    int column = int(constrain(lookup.x/resolution, 0, cols-1));
    int row = int(constrain(lookup.y/resolution, 0, rows-1));
    return field[column][row].copy();
  }

  // -------------------------------------------------------------------DEPOSIT PHEROMONE

  void depositPher(Vec3D dep, Vec3D pheromone) {
    int column = int(constrain(dep.x/resolution, 0, cols-1));
    int row = int(constrain(dep.y/resolution, 0, rows-1));
    field[column][row] = pheromone.copy();
  }
}

