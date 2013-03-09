import SimpleOpenNI.*;
SimpleOpenNI context; 
boolean handsTrackFlag = false; 
PVector handVec = new PVector();

void setup() {
  size(640, 480);  // strange, get drawing error in the cameraFrustum if i use P3D, in opengl there is no problem
  //size(1024,768,OPENGL);
  context = new SimpleOpenNI(this);
  context.setMirror(false);
  context.enableDepth();
  context.enableRGB();
  //unfortunately have to track guestures to get hands
  context.enableGesture();
  context.enableHands();
  context.addGesture("RaiseHand");
  fill(255, 0, 0);
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
}

