// Juillet 2016 dans l'avion vers Dubai et à Dubai
// Les mouvements se controlenet au clavier, voir keypressed.

import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer song;
AudioInput in;
BeatDetect beat;
float dureePulse = 0;

cylindre mesCylindres[];
spread mesSpreadX[];
spread mesSpreadY[];
spread mesSpreadZ[];

// les Balles
int nbeBalles = 6;
Ball[] balls =  { 
  new Ball(100, 400, 20), 
  new Ball(200, 400, 30),
  new Ball(200, 300, 10),
  new Ball(300, 400, 15),
  new Ball(500, 400, 40),
  new Ball(600, 400, 50),
  new Ball(400, 600, 60)
};

// Variable du cylindre et du mouvement
int totalCylindres = 10;
int maxTotalCylindres = 10;

int   definitions[]; // pour le nbe de segment et la taille du spread
float amplitudes[];  //  pour le spread
float incrementPhases[]; // pour le mouvement ondulatoire du spread
float hauteurs[]; //  pour le cylindre
float rayons[];   // pour le cylindre
int   cotes[] ; // pour le cylindre
float phases[];

// Pour la sphere
boolean displaySphere = false;
float posSphereX = 0;
float posSphereY = 0;
float posSphereZ = random(width);
float angleSphere = 0;
float agitation = random(50,500);
boolean showSpheres = false;

// Pour le fond
float inc = 0.06;
int density = 4;
float znoise = 0.0;

void setup()
{
    size(649, 400, P3D);
    
    minim = new Minim(this);
    //minim.debugOn();
    
    // get a line in from Minim, default bit depth is 16
    in = minim.getLineIn(Minim.STEREO, int(1024));
    
    // a beat detection object song SOUND_ENERGY mode with a sensitivity of 10 milliseconds
    beat = new BeatDetect();
    
    //fullScreen(P3D,2);
    noCursor();
    //smooth();
    
    initValues();
    
    mesCylindres = new cylindre[totalCylindres];
    mesSpreadX = new spread[totalCylindres];
    mesSpreadY = new spread[totalCylindres];
    mesSpreadZ = new spread[totalCylindres];

    for(int i=0; i < totalCylindres; i++) {
      mesCylindres[i] = new cylindre(cotes[i], rayons[i], hauteurs[i], definitions[i]);
      mesSpreadY[i] = new spread(definitions[i]);
      mesSpreadZ[i] = new spread(definitions[i]);
      mesSpreadY[i].onduleSpread(amplitudes[i], 0); 
      mesSpreadZ[i].onduleSpread(amplitudes[i], 0); 
      mesCylindres[i].modifCylindreY(mesSpreadY[i]);
      mesCylindres[i].modifCylindreY(mesSpreadY[i]);
    }

    totalCylindres = 1; // Pour le premier affichage
}

void draw()
{
    background(61,88,106);
    //lights();

    // point light on the center
    pointLight(245, 249, 252, // Color
    width/2, height/2, 100); // Position
    
    // point light 
    pointLight(245, 249, 252, // Color
    -20, height/2, 100); // Position
    
/*
    // directional light from the left
    directionalLight(245, 249, 252, // Color
    1, 0, 100); // The x-, y-, z-axis direction
    
    // spotlight from the front
    spotLight(245, 249, 252, // Color
    width/2, height/2, 100, // Position
    0, 10, 10, // Direction
    PI/2, 2); // Angle, concentration       
*/
    
    //fill(153, 128, 0);
    fill(80,146,157);
    noStroke();
    //stroke(140);
   
    beat.detect(in.mix);
    if ( beat.isOnset()) {
      displaySphere = true;
      dureePulse = 0;
    } else if (dureePulse < 20) {
      dureePulse ++;
      displaySphere = true;
    } else displaySphere = false;
    
    pushMatrix();    // Les Cylindres
    translate( 110, height/2, 0 );
    //rotateZ( PI );
    rotateY( PI/2 );
    //rotateX( PI/2 );
    //rotateY( radians( frameCount ) );
    translate( 0, 0, -100);  
    
    for(int i=0; i < totalCylindres; i++) {
       phases[i] += incrementPhases[i];
       mesSpreadY[i].onduleSpread(amplitudes[i], phases[i]); 
       mesSpreadZ[i].onduleSpread(amplitudes[i], phases[i]); 
       mesCylindres[i].modifCylindreY(mesSpreadY[i]);
       mesCylindres[i].drawCylindre(TRIANGLE_STRIP); 

       rotateZ( radians( frameCount ) );
       translate( 0, 30, 0);
    }
 
    posSphereY = height/4 * sin(angleSphere);
    posSphereZ = width/4 * cos(angleSphere);
    angleSphere += PI/agitation;
    
   if (displaySphere) { 
      fill(92,103,106);
      translate(0, posSphereY-height/4, posSphereZ+width/2);
      sphere(50);
    }
    
    popMatrix(); // Fin des affichages cylindres et sphere
    
    // Remise en position initiale des cylindre pour pouvoir ajouter la modification du spread
    // Sinon tout s'ajoute en permanence
    for(int i=0; i < totalCylindres; i++) {
       mesCylindres[i].initCylindre();
       } 
        
    // Dessin des balles
    for (Ball b : balls) {
        b.update();
        if (showSpheres) b.display();
        b.checkBoundaryCollision();
     }

  /*
  // Une possibilité pour éviter qq collisions, avec des effets d'absorbtion de certaines balles étonnant.
  for(int i=0; i < nbeBalles; i++) {
    for(int j=i; j < nbeBalles; j++) {
      balls[i].checkCollision(balls[j]);
    }
  }
  */
  //saveFrame(); // Pour faire un film
}

void initValues() {
  definitions= new int[totalCylindres]; 
  amplitudes = new float[totalCylindres];
  incrementPhases = new float[totalCylindres];
  hauteurs = new float[totalCylindres];
  rayons = new float[totalCylindres];
  cotes =  new int[totalCylindres]; 
  phases = new float[totalCylindres];
                
  for(int i=0; i < totalCylindres; i++) {
    amplitudes[i] = random(10, 35);
    incrementPhases[i] = random(0.01, 0.1);
    hauteurs[i] = 5;
    definitions[i] = int(width/hauteurs[i])-3;
    rayons[i] = 10;
    cotes[i] = 15;
    phases[i] = 0;
  }
}

void keyPressed() {
  switch(key) {
  case ' ':
    displaySphere = !displaySphere;
    posSphereZ = random(width);
    agitation = random(50,500);
    break;
  case 'p':
      println("--------------------------");
      for(int i=0; i < totalCylindres; i++) {
         incrementPhases[i] = 0.1 + random(0.01, 0.1);
         println(incrementPhases[i]);
      }
      break;
  case '+':
        for(int i=0; i < totalCylindres; i++) {
         incrementPhases[i] += 0.02;
      }
      break;
  case '-':
        for(int i=0; i < totalCylindres; i++) {
         incrementPhases[i] -= 0.02;
      }
      break;
  case 's': 
      showSpheres = !showSpheres;
      break;
  case '1': totalCylindres = 1; break;
  case '2': totalCylindres = 2; break;
  case '3': totalCylindres = 3; break;
  case '4': totalCylindres = 4; break;
  case '5': totalCylindres = 5; break;
  case '6': totalCylindres = 6; break;
  case '7': totalCylindres = 7; break;
  case '8': totalCylindres = 8; break;
  case '9': totalCylindres = 9; break;
  default:
  }
}

void stop()
{
  // always close Minim audio classes when you are finished with them
  //song.close();
  in.close();
  // always stop Minim before exiting
  minim.stop();
 
  super.stop();
} 