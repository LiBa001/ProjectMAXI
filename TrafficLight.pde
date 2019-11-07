class TrafficLight {
  /** Represents a traffic light */
  
  int posX, posY, size;  // position and size
  boolean rotate, flip;  // rotate 90 deg, flip light order
  
  // colors for lights turned on and turned off
  final color[] colors_on = {color(255, 0, 0), color(255, 255, 0), color(0, 255, 0)};
  final color[] colors_off = {color(100, 0, 0), color(100, 100, 0), color(0, 100, 0)};
  
  int state, waiting;
  final static int waitedState = 4;  // how many states to stay red (wait for other TLs to change their state)
  final static int OFF = 0, RED = 6, RED_YELLOW = 5, YELLOW = 3, GREEN = 2;  // color constants
  final int[] STATES = {OFF, RED, RED_YELLOW, YELLOW, GREEN};  // array of all color constants
  
  
  TrafficLight(int posX, int posY, int size, boolean rotate, boolean flip) {
    // Constructor method: Creates an instance of this class.
    
    this.posX = posX;
    this.posY = posY;
    this.size = size;
    this.rotate = rotate;
    this.flip = flip;
    this.state = OFF;
    this.waiting = 0;
  }
  
  void draw() {
    // Draws the traffic light to the screen, depending to the current state.
    
    // outside box
    int boxWidth = this.size;
    int boxHeight = boxWidth * 2;
    
    fill(color(0));
    
    // draw traffic light boxes depending on rotation
    if (!this.rotate) {
      rect(this.posX, this.posY, boxWidth, boxHeight, 4);
    } else {
      rect(this.posX, this.posY, boxHeight, boxWidth, 4);
    }
    
    // inner lights
    float radius = boxWidth/2 - boxWidth*0.01;
    int lightPosX;
    
    // set light position depending on rotation
    if (!this.rotate) {
      lightPosX = this.posX + boxWidth/2;
    } else {
      lightPosX = this.posY + boxWidth/2;
    }
    
    for (int i = 1; i <= 3; i++) {
      // calculate the light's state
      // RED:    1 * 6 == 6
      // YELLOW: 2 * 3 == 6
      // GREEN:  3 * 2 == 6
      
      // fill light with appropriate color depending on the state
      if (i * this.state == 6 || (i < 3 && this.state == 5)) {
        fill(colors_on[i-1]);
      } else {
        fill(colors_off[i-1]);
      }
      
      // draw light dependent on wether rotated and flipped
      int factor = !this.flip ? i : -i;  // flipping order
      float bias = !this.flip ? 0 : 1.333 * boxHeight;  // shifting lights
      
      if (!this.rotate) {
        ellipse(lightPosX, this.posY + factor*boxHeight/3 - boxHeight/6 + bias, radius, radius);
      } else {
        ellipse(this.posX + factor*boxHeight/3 - boxHeight/6 + bias, lightPosX, radius, radius);
      }
    }
  }
  
  int nextState() {
    // Switches the traffic light to the next lighting state.
    
    switch (this.state) {
      case OFF:
      case RED_YELLOW:
        this.state = GREEN;
        break;
      case GREEN:
        this.state = YELLOW;
        break;
      case YELLOW:
        this.state = RED;
        break;
      case RED:
        if (waitedState > this.waiting) {
          this.waiting++;
        } else {
          this.waiting = 0;
          this.state = RED_YELLOW;
        }
        break;
    }
    
    return this.state;
  }
  
}
