class spread {
float ceSpread[];
int longueur;


  spread(int l) {
    longueur = l;
    ceSpread = new float[l];
    for (int i=0; i < l ; i++) ceSpread[i] = 0;
  }

  void printSpread() {
     for (int i=0; i < longueur ; i++) { print(ceSpread[i], "!");}
     println();
  }
  
  float getSpread(int i) {
    return(ceSpread[i]);
  }
  
  int getLongueur() {
    return(longueur);
  }

  void setSpread(float value, int i) {
    ceSpread[i] = value;
  }

 void onduleSpread(float amplitude, float phase) {
    float angle = 0;
    for (int i=0; i < longueur ; i++) {
       ceSpread[i] = amplitude * sin(angle + phase);
       angle = (TWO_PI/longueur) * i; // On définit la période sur la durée du spread.
    }
 }
}