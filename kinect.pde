// ----------------------------------------------------------------- // hand events
void onCreateHands(int handId, PVector pos, float time) {
  println("onCreateHands - handId: " + handId + ", pos: " + pos + ", time:" + time);
  handsTrackFlag = true;
  handVec = pos;
}
void onUpdateHands(int handId, PVector pos, float time) {
  //println("onUpdateHandsCb - handId: " + handId + ", pos: " + pos + ", time:" + time);
  //store the location of the hand in a vector object
  handVec = pos;
}
void onDestroyHands(int handId, float time) {
  println("onDestroyHandsCb - handId: " + handId + ", time:" + time);
  handsTrackFlag = false;
  //go back to looking for the guesture that gave you hand.
  context.addGesture("RaiseHand");
}
// ----------------------------------------------------------------- // gesture events
void onRecognizeGesture(String strGesture, PVector idPosition, PVector endPosition) {
  println("onRecognizeGesture - strGesture: " + strGesture + ", idPosition: " + idPosition + ", endPosition:" + endPosition);
  //stop looking for the gesture
  context.removeGesture(strGesture);
  //use the location of this guesture tell you where to start tracking the hand
  context.startTrackingHands(endPosition);
}
void onProgressGesture(String strGesture, PVector position, float progress) {
  //println("onProgressGesture - strGesture: " + strGesture + ", position: " + position + ", progress:" + progress);
}
// ----------------------------------------------------------------- // Keyboard event
void keyPressed() {
  switch(key)
  {
  case ' ':
    context.setMirror(!context.mirror());
    break;
  }
}
