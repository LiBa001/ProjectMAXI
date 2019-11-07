import processing.serial.*;


// defining the serial connection
final int BAUDRATE = 9600;
final String port = Serial.list()[0];
final Serial conn = new Serial(this, port, BAUDRATE);


class Arduino {
  /** Represents the arduino connection. */
  
  private Intersection intersec;
  
  Arduino(Intersection intersec) {
    this.intersec = intersec;
  }
  
  void sendState() {
    /** Sends current intersection state to Arduino. */
    
    int state = intersec.stateCounter;
    conn.write(state);
  }
  
}
