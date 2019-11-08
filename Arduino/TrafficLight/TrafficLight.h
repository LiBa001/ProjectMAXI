#ifndef TrafficLight_h
#define TrafficLIght_h

#include "Arduino.h"

class TrafficLight {
  private:
  int _greenPin;
  int _yellowPin;
  int _redPin;
  int _state;
  
  public:
  TrafficLight(int greenPin, int yellowPin, int redPin);
  int setState(int newState);
  const static int OFF = 0, GREEN = 1, YELLOW = 2, RED = 3, RED_YELLOW = 4;
};

#endif
