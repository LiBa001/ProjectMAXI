// declare traffic lights
TrafficLight tl1;
TrafficLight tl2;
TrafficLight tl3;
TrafficLight tl4;

// declare intersection
Intersection intersec;

private boolean runIntersection = false;


void setup() {
  size(640, 360);
  surface.setTitle("Traffic Lights");
  surface.setResizable(false);
  
  noLoop();
  
  // responsive traffic light positions
  int tlSize = 50;  // traffic light size
  int tlMargin = 5;
  int tlPosX = width/2, tlPosY = height/2;
  int leftOrUpRotate = -tlSize*2 - tlMargin;  // use for x->left or when rotate y->up
  int leftRotateOrUp = -tlSize*3 - tlMargin;  // use for x->left when rotate or y->up
  int rightOrDown = tlSize + tlMargin;        // use for x->right or y->down
  
  
  // create traffic lights
  tl1 = new TrafficLight(tlPosX + leftOrUpRotate, tlPosY + leftRotateOrUp, tlSize, false, true);
  tl2 = new TrafficLight(tlPosX + rightOrDown,    tlPosY + leftOrUpRotate, tlSize, true, false);
  tl3 = new TrafficLight(tlPosX + leftRotateOrUp, tlPosY + rightOrDown,    tlSize, true, true);
  tl4 = new TrafficLight(tlPosX + rightOrDown,    tlPosY + rightOrDown,    tlSize, false, false);
  
  // grouping traffic lights and create intersection
  TrafficLight[] group1 = {tl1, tl4};
  TrafficLight[] group2 = {tl2, tl3};
  
  intersec = new Intersection(group1, group2);
  
  // setup the TrafficLights' states to match realistic bahaviour
  intersec.setupLights();
}


void draw() {
  // draw the scene
  background(200);
  noStroke();
  intersec.draw();
  drawStreets(100, 10);
  
  if (runIntersection) {
    loop();  // run draw in a loop
    intersec.run();  // run intersection
  } else {
    noLoop();  // stop running draw in a loop
  }
}


void keyPressed() {
  /**
  Listens for key presses.
  Enables interaction with the traffic lights.
  
  Key:    Action:
     0    turn all OFF
     1    switch all to GREEN
     2    switch all to YELLOW
     3    switch all to RED
     4    switch all to RED_YELLOW
  SPACE   switch all to next state
  ENTER   setup and run all lights as intersection
  
  */
  
  runIntersection = false;
  
  switch (key) {
    case '0': 
      intersec.switchAllStates(TrafficLight.OFF);
      break;
    case '1': 
      intersec.switchAllStates(TrafficLight.GREEN);
      break;
    case '2': 
      intersec.switchAllStates(TrafficLight.YELLOW);
      break;
    case '3': 
      intersec.switchAllStates(TrafficLight.RED);
      break;
    case '4': 
      intersec.switchAllStates(TrafficLight.RED_YELLOW);
      break;
    case ' ': 
      intersec.nextState();
      break;
    case ENTER: 
      intersec.setupLights();
      runIntersection = true;
      break;
  }
  
  redraw();
}


// ----- Streets definition and graphical representation -----


void drawStreets(int streetWidth, int strokeWidth) {
  // Draws the streets.
  // One horizontally and one vertically.
  
  int x = (width - streetWidth) / 2;
  int y = (height - streetWidth) / 2;
  int strokeX = (width - strokeWidth) / 2;
  int strokeY = (height - strokeWidth) / 2;
  
  fill(color(0));
  rect(x, 0, streetWidth, height);
  rect(0, y, width, streetWidth);
  
  fill(color(255));
  for (int i = 0; i < 5; i++) {
    rect(strokeX, height/20 + i*(height/5), strokeWidth, height/10);
  }
  for (int i = 0; i < 5; i++) {
    rect(width/20 + i*(width/5), strokeY, width/10, strokeWidth);
  }
  
}
