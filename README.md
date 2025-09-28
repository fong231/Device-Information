# Flutter Plugins Project

This project demonstrates how to create and use custom Flutter plugins to access native device
sensors on **Android** and **iOS**.  
It includes the following sensors:

- **Gyroscope Sensor**
- **Orientation Sensor** (Accelerometer + Magnetometer)
- **Light Sensor** (Ambient light / Screen brightness on iOS)

---

## 🛠️ Getting Started

### Prerequisites

- Flutter SDK (latest stable)
- Android Studio / VSCode / Xcode or any other IDE
- A real device (some sensors may not work on emulators/simulators)

### Installation

1. Extract the project files to a directory of your choice.
2. Open the folder named `main_project` in Android Studio/VSCode/Xcode or
   any other IDE.
3. Run

```bash
flutter pub get
```

```bash
flutter run
```

4. Run the app on a connected device.

---
root/
├── gyroscope_sensor_plugin/            (light_sensor_plugin and orientation_sensor_plugin are
similar)
│ ├── android/
│ │ ├── ... java file to access gyroscope sensor
│ ├── ios/
│ │ └── ... swift file to access gyroscope sensor
│ └── lib/
│ └── ... dart file for main_project to use the plugin
└── main_project/
└── lib/
└── ... dart files for the main app