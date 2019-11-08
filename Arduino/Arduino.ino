#include <TrafficLight.h>

// each digit in the string is the state of one traffic light
String states = "0000";

// creating traffic light objects and pass pin numbers
TrafficLight tl1(8, 9, 10);
TrafficLight tl2(11, 12, 13);

// creating array with all traffic lights objects
TrafficLight trafficLights[] = {tl1, tl2};

void setup() {
  Serial.begin(9600);  // start serial connection
}

void loop() {
  
  // check if the serial connection received something
  if (Serial.available() > 0) {
    
    // receive new states for all traffic lights
    states = Serial.readStringUntil(';');
    
    // iterate over traffic lights
    for (int i = 0; i < sizeof(trafficLights); i++) {
      
      // Get this light's new state
      // and convert it to an integer.
      int state = int(states[i]) - '0';
      
      Serial.println(state);  // print recieved state for debugging purpose
      
      // set this traffic light's state to the received state
      trafficLights[i].setState(state);
    }
  }
}
