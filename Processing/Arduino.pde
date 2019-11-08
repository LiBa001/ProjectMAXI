import processing.serial.*;


// defining the serial connection
final int BAUDRATE = 9600;
final String port = Serial.list()[0];
final Serial conn = new Serial(this, port, BAUDRATE);


class Arduino {
  /** Represents the arduino connection. */
  
  public static final int OFF = 0, GREEN = 1, YELLOW = 2, RED = 3, RED_YELLOW = 4;
  
  private TrafficLight[] trafficLights;
  
  Arduino(TrafficLight[] trafficLights) {
    this.trafficLights = trafficLights;
    
    println("Connected to port: " + port);
  }
  
  void sendStates() {
    /** Sends current intersection state to Arduino. */
    
    String states[] = new String[4];
    int state;
    
    for (int i = 0; i < 4; i++) {
      state = this.trafficLights[i].state;
      
      switch (state) {
        case TrafficLight.OFF:
          state = OFF;
          break;
        case TrafficLight.GREEN:
          state = GREEN;
          break;
        case TrafficLight.YELLOW:
          state = YELLOW;
          break;
        case TrafficLight.RED:
          state = RED;
          break;
        case TrafficLight.RED_YELLOW:
          state = RED_YELLOW;
          break;
      }
      
      states[i] = str(state);
    }
    
    String statesString = join(states, "") + ';';
    
    println(statesString);
    
    conn.write(statesString);
  }
  
}
