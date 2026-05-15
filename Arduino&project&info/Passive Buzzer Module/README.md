# Passive Buzzer Module <img width="225" height="225" alt="17788243424784487826849034060440" src="https://github.com/user-attachments/assets/5a154e8d-6332-47d5-94ae-5074785c414d" />


Unlike an active buzzer, a passive buzzer requires an internal frequency (PWM signal) to create sound. This allows you to generate different tones and play melodies rather than just a single "beep."

---

## 🛠 Technical Specifications
* **Operating Voltage:** 3.3V - 5V DC
* **Current Consumption:** <25mA
* **Sound Type:** PWM controlled (can play different frequencies)
* **Tone Range:** 1.5 kHz – 2.5 kHz (Typical)

---

## 🔌 Pinout & Wiring
Refer to the circuit diagram below for the correct connections.

<img width="779" height="533" alt="Screenshot_20260515_095547_Chrome" src="https://github.com/user-attachments/assets/d27f6a5f-bc06-4433-88a9-e4c828d60d12" />


| Module Pin | Arduino Pin | Description |
| :--- | :--- | :--- |
| **PIN / +** | Pin 8 | Digital Signal (PWM) |
| **GND / -** | GND | Ground Connection |

---

## 🔌 Project Circuit
Connect the buzzer directly to a digital pin that supports PWM for the best results.



---

## 📝 Sample Program
This script plays a simple "Siren" effect by sweeping through frequencies.

```cpp
const int BUZZER_PIN = 8; // Connect buzzer to Pin 8

void setup() {
  pinMode(BUZZER_PIN, OUTPUT);
}

void loop() {
  // Sweep frequency up
  for (int i = 200; i <= 1000; i += 10) {
    tone(BUZZER_PIN, i);
    delay(10);
  }

  // Sweep frequency down
  for (int i = 1000; i >= 200; i -= 10) {
    tone(BUZZER_PIN, i);
    delay(10);
  }
}
