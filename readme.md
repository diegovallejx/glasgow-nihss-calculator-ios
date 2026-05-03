# Glasgow Coma Scale & NIHSS Calculator

![Swift](https://img.shields.io/badge/Swift-5.9-orange?logo=swift)
![Platform](https://img.shields.io/badge/Platform-iOS%2016%2B-blue?logo=apple)
![Xcode](https://img.shields.io/badge/Xcode-15%2B-blue?logo=xcode)
![Clinical Tool](https://img.shields.io/badge/Clinical%20Tool-Neurology-green)
![License](https://img.shields.io/badge/License-MIT-lightgrey)

A modern iOS clinical tool for rapid bedside assessment using the **Glasgow Coma Scale (GCS)** and the **NIH Stroke Scale (NIHSS)**, built with SwiftUI.

Developed by a critical care nurse with 8 years of experience in a medical-neurosurgical ICU - IMCU, this app reflects real clinical workflow needs: fast input, instant interpretation, and safety alerts when they matter most.

---

## Features

### Glasgow Coma Scale
- Structured input for ocular (E), verbal (V), and motor (M) responses using standardized GCS options
- Automatic total score calculation with severity interpretation:
  - 🟢 **Mild** (13–15)
  - 🟡 **Moderate** (9–12)
  - 🔴 **Severe** (≤ 8)
- Automatic airway protection alert: **⚠️ Glasgow ≤ 8 — Consider protecting airway**
- Quick-clear button to reset all fields for a new patient
- Score displayed per component (E, V, M) immediately after selection

### NIHSS (NIH Stroke Scale)
- Full NIHSS assessment accessible from the main GCS screen
- Navigation via toolbar button or horizontal swipe gesture

### UX & Design
- Built with `NavigationStack` and native `Form` layout
- Minimal, distraction-free interface optimized for clinical settings
- Immediate visual feedback on every selection
- Fast navigation between GCS and NIHSS views

---

## Screenshots

*(Coming soon)*

---

## Clinical Context

This app was designed for use in **adult critical care and neurosurgical units**. The GCS thresholds and alert logic follow internationally recognized clinical criteria:

| Score | Severity | Clinical Action |
|-------|----------|----------------|
| 13–15 | Mild | Monitor |
| 9–12 | Moderate | Close monitoring, consider imaging |
| ≤ 8 | Severe | **Consider airway protection** |

The airway alert (GCS ≤ 8) fires automatically as scores are entered, supporting rapid clinical decision-making without requiring the clinician to remember the threshold.

---

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Language | Swift 5.9 |
| UI Framework | SwiftUI |
| Navigation | NavigationStack |
| State Management | `@State`, `Binding<Int>` with nil-mapping |
| Minimum iOS | iOS 16.0 |
| IDE | Xcode 15+ |

---

## Architecture

GlasgowNIHSSApp/
├── ContentView.swift        # GCS main view — input scoring, alert logic
├── NIHSSView.swift          # NIHSS assessment view
└── GlasgowNIHSSApp.swift    # App entry point

**Key implementation decisions:**

- GCS scores stored as `@State var score: Int?` to represent the unselected state explicitly, avoiding ambiguous zero-values
- Each `Picker` uses a `Binding<Int>` that maps `nil → -1` internally, enabling a native "Select" placeholder option with `.tag(-1)`
- `onChange(of: total)` observes the computed score and triggers the airway alert modal when `total <= 8`
- `DragGesture` with a 50pt threshold enables swipe-to-NIHSS navigation as a secondary affordance

---

## Getting Started

```bash
git clone https://github.com/diegovallejx/glasgow-nihss-calculator-ios.git
cd glasgow-nihss-calculator-ios
open GlasgowNIHSSApp.xcodeproj
```

Build and run on Simulator or a physical device (iOS 16+).

No external dependencies. No CocoaPods. No Swift Package Manager packages required.

---

## Roadmap

- [ ] App Store publication
- [ ] Pediatric GCS variant
- [ ] Score history / session log
- [ ] Export report as PDF
- [ ] Integration with sedoanalgesia calculator (companion app)

---

## Author

**Diego Vallejos A.**  
Registered Nurse · Critical Care · Medical-Neurosurgical IMCU  
Complejo Asistencial Dr. Víctor Ríos Ruiz, Los Ángeles, Chile  

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-blue?logo=linkedin)](https://linkedin.com/in/diego-vallejos-ag2026)
[![GitHub](https://img.shields.io/badge/GitHub-Follow-black?logo=github)](https://github.com/diegovallejx)

---

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.

---

> **Disclaimer:** This application is a clinical support tool. It does not replace the professional judgment of a licensed healthcare provider.