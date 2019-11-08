// declare traffic light objects
TrafficLight tl1;
TrafficLight tl2;
TrafficLight tl3;
TrafficLight tl4;

// declare intersection
Intersection intersec;

// disable running intersection loop by default
private boolean runIntersection = false;

// declare arduino connection
Arduino arduino;


void setup() {
  size(640, 360);  // set screen size
  surface.setTitle("Traffic Lights AKA ProjectMAXI");  // set window title
  surface.setResizable(false);  // set window to not being resizable
  
  noLoop();  // don't run `draw()` in a loop
  
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
  
  // create arduino instance
  TrafficLight[] trafficLights = {tl1, tl2, tl3, tl4};
  arduino = new Arduino(trafficLights);
}


void draw() {
  // draw the scene
  background(200);  // set background color to light grey
  noStroke();
  intersec.draw();
  drawStreets(100, 10);  // draw streets 100px width and strokes 10px width
  
  if (runIntersection) {
    loop();  // run draw in a loop
  } else {
    noLoop();  // stop running draw in a loop
    arduino.sendStates();  // send new states to arduino
  }
}


void runIntersectionLoop() {
  /**
  Run the intersection in a loop until a key is pressed
  and therefore `runIntersection` is set to `false`.
  
  This is supposed to be called in a new thread.
  */
  
  while (runIntersection) {
    intersec.run();  // wait specified amount of time and rotate states
    arduino.sendStates();  // send new states to arduino
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
  
  // disable running intersection loop by default
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
      intersec.nextState();  // rotate states for all traffic lights
      break;
    case ENTER: 
      intersec.setupLights();  // set light states to normal
      arduino.sendStates();  // synchronize states with arduino
      runIntersection = true;  // enable running intersection loop
      
      // Run intersection loop in new thread.
      // This calls function `runIntersectionLoop()` in a new thread.
      thread("runIntersectionLoop");
      
      break;
  }
  
  redraw();  // redraw screen after states might have changed
}


// ----- Streets definition and graphical representation -----


void drawStreets(int streetWidth, int strokeWidth) {
  // Draws the streets.
  // One horizontally and one vertically.
  
  // define responsive street and stroke coordinates
  int x = (width - streetWidth) / 2;
  int y = (height - streetWidth) / 2;
  int strokeX = (width - strokeWidth) / 2;
  int strokeY = (height - strokeWidth) / 2;
  
  fill(color(0));  // fill with black
  rect(x, 0, streetWidth, height);  // draw vertical street
  rect(0, y, width, streetWidth);  // draw horizontal street
  
  fill(color(255));  // fill with white
  
  // draw 5 lines in the middle of the street
  for (int i = 0; i < 5; i++) {
    // for vertical street
    rect(strokeX, height/20 + i*(height/5), strokeWidth, height/10);
  }
  for (int i = 0; i < 5; i++) {
    // for horizontal street
    rect(width/20 + i*(width/5), strokeY, width/10, strokeWidth);
  }
  
}
