//Melissa dela Merced 
//Nature of Code midterms
//Built on SimpleOpenNI and Toxiclibs

//toxiclibs library import
import toxi.geom.*;
import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
//simpleOpenNI library import
import SimpleOpenNI.*;
SimpleOpenNI context; 
boolean handsTrackFlag = false; 
PVector handVec = new PVector();

ArrayList<Particle> particles;
Attractor attractor;

VerletPhysics2D physics;

void setup() {
  size(640, 480);  // strange, get drawing error in the cameraFrustum if i use P3D, in opengl there is no problem
  //size(1024,768,OPENGL);

  //initialize kinect commands
  context = new SimpleOpenNI(this);
  context.setMirror(false);
  context.enableDepth();
  context.enableRGB();
  //unfortunately have to track guestures to get hands
  context.enableGesture();
  context.enableHands();
  context.addGesture("RaiseHand");
  fill(255, 0, 0);

  //toxiclibs particle initialization
  physics = new VerletPhysics2D ();
  physics.setDrag (0.01);

  particles = new ArrayList<Particle>();
  for (int i = 0; i < 50; i++) {
    particles.add(new Particle(new Vec2D(random(width), random(height))));
  }

  attractor = new Attractor(new Vec2D(width/2, height/2));
}
void draw() {
  // update the cam
  context.update();
  //paint the image
  PImage rgbImage = context.rgbImage();
  image(rgbImage, 0, 0, width, height);
  if (handsTrackFlag) 
  {
    PVector myPositionScreenCoords  = new PVector(); //storage device
    //convert the weird kinect coordinates to screen coordinates.
    context.convertRealWorldToProjective(handVec, myPositionScreenCoords);
    ellipse(myPositionScreenCoords.x, myPositionScreenCoords.y, 20, 20);
  }

  //draw toxiclibs particles
  physics.update ();

  attractor.display();
  for (Particle p: particles) {
    p.display();
  }

  if (mousePressed) {
    attractor.lock();
    attractor.set(mouseX, mouseY);
  } 
  else {
    attractor.unlock();
  }
}

