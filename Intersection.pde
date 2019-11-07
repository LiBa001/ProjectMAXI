class Intersection {
  /** 
  Represents an intersection
  which consists of two traffic light groups that complementary switch states.
  */
  
  TrafficLight[] group1, group2;
  
  private int stateCounter;
  
  static final int SHORT_DELAY = 1000, LONG_DELAY = 5000;
  static final int numStates = 4;  // the number of states
  
  Intersection(TrafficLight[] group1, TrafficLight[] group2) {
    this.group1 = group1;
    this.group2 = group2;
    this.stateCounter = numStates;
  }
  
  private int switchGroupState(TrafficLight[] group, int state) {
    for (int i = 0; i < group.length; i++) {
      group[i].state = state;
    }
    return state;
  }
  
  void switchAllStates(int state) {
    this.switchGroupState(this.group1, state);
    this.switchGroupState(this.group2, state);
  }
  
  void setupLights() {
    for (int i = 0; i < this.group1.length; i++) {
      this.group1[i].state = TrafficLight.RED;
      this.group1[i].waiting = TrafficLight.waitedState/2;
    }
    this.switchGroupState(this.group2, TrafficLight.GREEN);
    
    this.stateCounter = numStates -1;
  }
  
  void nextState() {
    for (int i = 0; i < group1.length; i++) {
      group1[i].nextState();
    }
    for (int i = 0; i < group2.length; i++) {
      group2[i].nextState();
    }
  }
  
  void draw() {
    for (int i = 0; i < group1.length; i++) {
      group1[i].draw();
    }
    for (int i = 0; i < group2.length; i++) {
      group2[i].draw();
    }
  }
  
  void run() {
    /** Runs the intersection.
    Basically like `Intersection.nextState`, but with state specific delay.
    */
    
    this.nextState();
    
    if (this.stateCounter < numStates) {
      this.stateCounter++;
      delay(SHORT_DELAY);
    } else {
      this.stateCounter = 1;
      delay(LONG_DELAY);
    }
  }
}
