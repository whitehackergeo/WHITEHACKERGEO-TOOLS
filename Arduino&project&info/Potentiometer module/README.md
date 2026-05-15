# Potentiometer (Rotary Variable Resistor) 

A potentiometer is a three-terminal resistor with a sliding or rotating contact that forms an adjustable voltage divider. In Arduino projects, it is used to provide an analog input that the board can read as a value between 0 and 1023.

---

## 🛠 Technical Specifications
* **Type:** Linear / Logarithmic
* **Standard Resistance:** 10kΩ (Typical for Arduino)
* **Rotation Angle:** 270° to 300°
* **Operating Voltage:** Up to 5V DC (When used with Arduino)

---

## 🔌 Pinout & Wiring
Unlike digital sensors, the potentiometer must be connected to an **Analog Input (A0-A5)** pin.

| Potentiometer Pin | Arduino Pin | Description |
| :--- | :--- | :--- |
| **Pin 1 (Left)** | GND | Ground |
| **Pin 2 (Middle)** | **A0** | Analog Signal (Wiper) |
| **Pin 3 (Right)** | 5V | Power Supply |

---

## 🖼 Component Layout
The middle pin is the "Wiper." As you turn the knob, the voltage on the middle pin changes between 0V and 5V.



---

## 🔌 Project Circuit
Connect the two outer pins to power and ground, and the center pin to an analog input.



---

## 📝 Sample Program
This script reads the position of the knob and prints the value (0 to 1023) to the Serial Monitor.

```cpp
const int POT_PIN = A0; // Middle pin of potentiometer
int potValue = 0;       // Variable to store the value

void setup() {
  Serial.begin(9600);
  Serial.println("Potentiometer Read Initialized...");
}

void loop() {
  // Read the analog value (0 to 1023)
  potValue = analogRead(POT_PIN);
  
  // Convert value to a voltage (0V - 5V)
  float voltage = potValue * (5.0 / 1023.0);

  Serial.print("Raw Value: ");
  Serial.print(potValue);
  Serial.print(" | Voltage: ");
  Serial.println(voltage);

  delay(100);
}
