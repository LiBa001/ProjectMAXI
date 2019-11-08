#include "Arduino.h"
#include "TrafficLight.h"


TrafficLight::TrafficLight(int greenPin, int yellowPin, int redPin) {
    _greenPin = greenPin;
    _yellowPin = yellowPin;
    _redPin = redPin;

    pinMode(greenPin, OUTPUT);
    pinMode(yellowPin, OUTPUT);
    pinMode(redPin, OUTPUT);

    _state = 0;
}

int TrafficLight::setState(int newState) {
    switch (newState) {
      case OFF:
        digitalWrite(_greenPin, LOW);
        digitalWrite(_yellowPin, LOW);
        digitalWrite(_redPin, LOW);
        break;
      case GREEN:
        digitalWrite(_greenPin, HIGH);
        digitalWrite(_yellowPin, LOW);
        digitalWrite(_redPin, LOW);
        break;
      case YELLOW:
        digitalWrite(_greenPin, LOW);
        digitalWrite(_yellowPin, HIGH);
        digitalWrite(_redPin, LOW);
        break;
      case RED:
        digitalWrite(_greenPin, LOW);
        digitalWrite(_yellowPin, LOW);
        digitalWrite(_redPin, HIGH);
        break;
      case RED_YELLOW:
        digitalWrite(_greenPin, LOW);
        digitalWrite(_yellowPin, HIGH);
        digitalWrite(_redPin, HIGH);
        break;
    }
    
    _state = newState;
    return newState;
}
