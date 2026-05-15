# HC-SR04 Ultrasonic Distance Measurement Module

The HC-SR04 is an ultrasonic distance measurement module designed for non-contact detection of objects and range measurement. It operates by emitting short bursts of ultrasonic sound waves and measuring the time required for the echo reflected from a target object to return to the receiver.

---

## 🛠 Technical Specification

* **Operating Voltage:** 5 V DC
* **Operating Current:** ≈15 mA
* **Ultrasonic Frequency:** 40 kHz
* **Measurement Range:** 2 cm – 400 cm
* **Distance Resolution:** ≈3 mm
* **Beam Angle:** ≈15°

---

## 🔌 Pinout & Wiring
IMAGE: <img width="865" height="618" alt="Screenshot_20260514_134929_Chrome" src="https://github.com/user-attachments/assets/65d89628-53de-4d03-a0b8-ef189a63c8c3" />


| Module Pin | Arduino Pin | Description |
| :--- | :--- | :--- |
| **VCC** | +5V | Power Supply (+5V) |
| **Trigger** | Pin 3 | Digital Output (Triggers the sensor) |
| **Echo** | Pin 2 | Digital Input (Receives the echo) |
| **GND** | GND | Ground Connection |

---

## 🖼 Component Layout
Below is the physical appearance of the module and its internal logic.
<img width="800" height="450" alt="17787535956697750160302796996081" src="https://github.com/user-attachments/assets/e5f5aaf8-9f10-41a7-9103-c21959e89637" />



---

## 📝 Sample Program
This script calculates the distance in centimeters and displays it on the Serial Monitor.

```cpp
// Refer to 1778750881198.jpeg
const int ECHO_PIN = 2; 
const int TRIGGER_PIN = 3; 

long duration;
float distance;

void setup() {
  pinMode(TRIGGER_PIN, OUTPUT);
  pinMode(ECHO_PIN, INPUT);
  Serial.begin(9600);
}

void loop() {
  // Ensure clean trigger pulse
  digitalWrite(TRIGGER_PIN, LOW);
  delayMicroseconds(2);

  digitalWrite(TRIGGER_PIN, HIGH);
  delayMicroseconds(10);
  digitalWrite(TRIGGER_PIN, LOW);

  // Timeout set to ~23.5 ms (max range ~400 cm)
  duration = pulseIn(ECHO_PIN, HIGH, 23500); 

  if (duration == 0) {
    Serial.println("No echo (out of range or no target)");
  } else {
    // distance = (time * speed of sound) / 2
    distance = duration * 0.0343 / 2; 
    Serial.print("Distance: ");
    Serial.print(distance);
    Serial.println(" cm");
  }
  delay(100);
}
