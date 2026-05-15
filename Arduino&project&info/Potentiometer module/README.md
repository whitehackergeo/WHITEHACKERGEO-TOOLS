# Potentiometer (Rotary Variable Resistor) 
<img width="1946" height="1946" alt="17788252155702193085091929152666" src="https://github.com/user-attachments/assets/9c0be43b-8e33-4020-9411-d6d3c4da2827" />

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

<img width="1024" height="509" alt="1778825352561707483678124337494" src="https://github.com/user-attachments/assets/084fdf4d-bcc9-4ec6-b07a-1e5a594164d9" />


| Potentiometer Pin | Arduino Pin | Description |
| :--- | :--- | :--- |
| **Pin 1 (Left)** | GND | Ground |
| **Pin 2 (Middle)** | **A0** | Analog Signal (Wiper) |
| **Pin 3 (Right)** | 5V | Power Supply |


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
