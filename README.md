# TrafficLights AKA ProjectMAXI

A simple traffic light intersection simulation with serial connection to Arduino.


This is intended to be used for educational purposes.

## The Processing Part
The [Processing](./Processing) sketch implements all the traffic light and intersection logic
and automatically tries to connect to an arduino via serial port.
It also features a graphical simulation of the intersection.

### Controls

> Hint: **TL** is used as an abbreviation for **traffic light**. 

| Key   | Function                   |
|:-----:| -------------------------- |
| 0     | Set all TLs off.           |
| 1     | Set all TLs green.         |
| 2     | Set all TLs yellow.        |
| 3     | Set all TLs red.           |
| 4     | Set all TLs red & yellow.  |
| SPACE | Rotate states for all TLs. |
| ENTER | Simulate intersection.     |


## The Arduino Part
The [Arduino](./Arduino) sketch consists of the actual `Arduino.ino` file
and a Arduino/C++ library containing the `TrafficLight` class for handling the
state and controlling the LEDs.
