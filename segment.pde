// Une modif pour voir

class segment {
  float posX[];
  float posY[];
  float posZ[];
  
  int nbSides;
  float rayon;
  float hauteur;
  int noSegment;

  segment(int sides, float r, float h, int noSeg) {
    rayon = r;
    nbSides = sides;
    hauteur = h;
    noSegment = noSeg;
    
    int tailleBuffer = sides + 1;
    posX = new float[tailleBuffer];
    posY = new float[tailleBuffer];
    posZ = new float[tailleBuffer];
    buildSegment(sides, r);
  }

 void buildSegment( int sides, float r) {
    float angle = 360 / sides;
    for (int i = 0; i < sides +1 ; i++) {
        posX[i] = cos( radians( i * angle ) ) * r;
        posY[i] = sin( radians( i * angle ) ) * r;
        posZ[i] = noSegment * hauteur;
    }
 }
 
 void rebuildSegment() {
    float angle = 360.0 / nbSides;
    for (int i = 0; i < nbSides + 1; i++) {
        posX[i] = cos( radians( i * angle ) ) * rayon;
        posY[i] = sin( radians( i * angle ) ) * rayon;
        posZ[i] = noSegment * hauteur;
    }
 }
 
 void printSegment() {
   for (int i = 0; i < nbSides + 1; i++) {
        println( "Vertex=",i, " !", posX[i], "!", posY[i], "!", posZ[i] );
    }
 }
  
 void drawSegment(int type) {
    beginShape(type);
    for (int i = 0; i < nbSides + 1; i++) {
        vertex( posX[i], posY[i], posZ[i]);
    }
    endShape(CLOSE);
 }
 
  void drawSegmentPoint() {
    beginShape(POINTS);
    for (int i = 0; i < nbSides + 1; i++) {
        vertex( posX[i], posY[i], posZ[i]);
    }
    endShape();
 }
  
 float getVertexPosX(int i) {
   return posX[i];
 }
 
 float getVertexPosY(int i) {
   return posY[i];
 }
 
 float getVertexPosZ(int i) {
   return posZ[i];
 }
 
 void addVertexPosX(float value, int i) {
   posX[i] += value;
 }
 
 void addVertexPosY(float value, int i) {
   posY[i] += value;
 }
 
 void setVertexPosY(float value, int i) {
   posY[i] = value;
 }
 
 void addVertexPosZ(float value, int i) {
   posZ[i] += value;
 }
 
}
