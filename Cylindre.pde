class cylindre {
  float posX[];
  float posY[];
  float posZ[];
  
  int nbSides;
  float rayon;
  float hauteur;
  int nbSegment;
  segment Segment[];
   
  cylindre(int sides, float r, float h, int seg) {
      rayon = r;
      hauteur = h;
      nbSides = sides;
      nbSegment = seg;
      
      Segment = new segment[nbSegment];
      for (int i=0; i < nbSegment ; i++){
        Segment[i] = new segment(nbSides, rayon, hauteur, i);
      }
   }

  void initCylindre() {
      for (int i=0; i < nbSegment ; i++){
        Segment[i].rebuildSegment();
      }
  }

 void printCylindre() {
   for (int j = 0; j < nbSegment ; j++) {
     println("Segment ", j, "---------------------------");
     Segment[j].printSegment();
   }
 }
  
  void drawCylindrePoint() {
  for (int j = 0; j < nbSegment ; j++) {
      Segment[j].drawSegment(POINTS);
   } 
  }
  
 void drawCylindre(int type) {
    beginShape(type);
    
    // pour fermer le premier triangle pas trés propre
    vertex(Segment[0].getVertexPosX(nbSides-1), Segment[0].getVertexPosY(nbSides-1), Segment[0].getVertexPosZ(nbSides-1));

    for (int i = 0; i < nbSegment - 1 ; i++) {
      for(int j = 0; j < nbSides ; j++) {
        vertex(Segment[i].getVertexPosX(j), Segment[i].getVertexPosY(j), Segment[i].getVertexPosZ(j));
        vertex(Segment[i+1].getVertexPosX(j), Segment[i+1].getVertexPosY(j), Segment[i+1].getVertexPosZ(j));
      }
    }
  
    // pour fermer le dernier triangle. pas trés propre...
    vertex(Segment[nbSegment-1].getVertexPosX(0), Segment[nbSegment-1].getVertexPosY(0), Segment[nbSegment-1].getVertexPosZ(0));
    endShape(CLOSE);
   }
   
   void modifCylindreX(spread Spread) {
   int longSpread;
   int k;
   longSpread = Spread.getLongueur();
   k = min(longSpread, nbSegment);
   for (int i = 0; i < k + 1; i++) { 
     for(int j = 0; j < nbSides +1 ; j++) {
         Segment[i].addVertexPosX(Spread.getSpread(i), j);
     }
   }
 }
   
 void modifCylindreY(spread Spread) {
   int longSpread;
   int k;
   longSpread = Spread.getLongueur();
   k = min(longSpread, nbSegment);
   for (int i = 0; i < k ; i++) { 
     for(int j = 0; j < nbSides + 1; j++) {
         Segment[i].addVertexPosY(Spread.getSpread(i), j);
     }
   }
 }
 
 void modifCylindreZ(spread Spread) {
   int longSpread;
   int k;
   longSpread = Spread.getLongueur();
   k = min(longSpread, nbSegment);
   for (int i = 0; i < k ; i++) { 
     for(int j = 0; j < nbSides + 1; j++) {
         Segment[i].addVertexPosZ(Spread.getSpread(i), j);
     }
   }
 }
 
}