import SwiftUI

struct NIHSSView: View {
    // NIHSS components as optional Ints (nil = not selected)
    @State private var loc: Int? = nil                 // 1a Nivel de consciencia
    @State private var locQuestions: Int? = nil        // 1b Preguntas LOC
    @State private var locCommands: Int? = nil         // 1c Órdenes LOC
    @State private var gaze: Int? = nil                // 2 Mirada
    @State private var visual: Int? = nil              // 3 Campos visuales
    @State private var facialPalsy: Int? = nil         // 4 Paresia facial
    @State private var motorArmLeft: Int? = nil        // 5a Brazo izq
    @State private var motorArmRight: Int? = nil       // 5b Brazo der
    @State private var motorLegLeft: Int? = nil        // 6a Pierna izq
    @State private var motorLegRight: Int? = nil       // 6b Pierna der
    @State private var limbAtaxia: Int? = nil          // 7 Ataxia de miembros
    @State private var sensory: Int? = nil             // 8 Sensibilidad
    @State private var language: Int? = nil            // 9 Lenguaje (Afasia)
    @State private var dysarthria: Int? = nil          // 10 Disartria
    @State private var extinctionInattention: Int? = nil // 11 Extinción/Desatención

    // Helpers to bind optional selections to Picker with -1 as "Seleccione"
    private func pickerBinding(_ value: Binding<Int?>) -> Binding<Int> {
        Binding(
            get: { value.wrappedValue ?? -1 },
            set: { newValue in value.wrappedValue = (newValue == -1) ? nil : newValue }
        )
    }

    private var total: Int? {
        // Sum only when all fields are selected
        let components: [Int?] = [
            loc, locQuestions, locCommands,
            gaze, visual, facialPalsy,
            motorArmLeft, motorArmRight,
            motorLegLeft, motorLegRight,
            limbAtaxia, sensory,
            language, dysarthria,
            extinctionInattention
        ]
        guard components.allSatisfy({ $0 != nil }) else { return nil }
        return components.compactMap { $0 }.reduce(0, +)
    }

    var body: some View {
        Form {
            // 1a LOC
            Section("1a. Nivel de consciencia (LOC)") {
                Picker("Nivel de consciencia", selection: pickerBinding($loc)) {
                    Text("Seleccione").tag(-1)
                    Text("0: Alerta").tag(0)
                    Text("1: Somnoliento / responde con estímulos mínimos").tag(1)
                    Text("2: Estupor").tag(2)
                    Text("3: Coma / no responde").tag(3)
                }
                .pickerStyle(.menu)
                if let loc { Text("Puntaje 1a: \(loc)").frame(maxWidth: .infinity, alignment: .center) }
            }

            // 1b LOC Questions
            Section("1b. Preguntas LOC") {
                Picker("Responde preguntas (mes/edad)", selection: pickerBinding($locQuestions)) {
                    Text("Seleccione").tag(-1)
                    Text("0: Responde ambas correctamente").tag(0)
                    Text("1: Responde una correctamente").tag(1)
                    Text("2: No responde o ambas incorrectas").tag(2)
                }
                .pickerStyle(.menu)
                if let locQuestions { Text("Puntaje 1b: \(locQuestions)").frame(maxWidth: .infinity, alignment: .center) }
            }

            // 1c LOC Commands
            Section("1c. Órdenes LOC") {
                Picker("Obedece órdenes (abrir cerrar ojos, mano)", selection: pickerBinding($locCommands)) {
                    Text("Seleccione").tag(-1)
                    Text("0: Obedece ambas").tag(0)
                    Text("1: Obedece una").tag(1)
                    Text("2: No obedece ninguna").tag(2)
                }
                .pickerStyle(.menu)
                if let locCommands { Text("Puntaje 1c: \(locCommands)").frame(maxWidth: .infinity, alignment: .center) }
            }

            // 2 Gaze
            Section("2. Mirada") {
                Picker("Desviación de la mirada", selection: pickerBinding($gaze)) {
                    Text("Seleccione").tag(-1)
                    Text("0: Normal").tag(0)
                    Text("1: Parálisis parcial de mirada").tag(1)
                    Text("2: Desviación forzada / parálisis completa").tag(2)
                }
                .pickerStyle(.menu)
                if let gaze { Text("Puntaje 2: \(gaze)").frame(maxWidth: .infinity, alignment: .center) }
            }

            // 3 Visual fields
            Section("3. Campos visuales") {
                Picker("Déficit de campos visuales", selection: pickerBinding($visual)) {
                    Text("Seleccione").tag(-1)
                    Text("0: Sin déficit").tag(0)
                    Text("1: Hemianopsia parcial").tag(1)
                    Text("2: Hemianopsia completa").tag(2)
                    Text("3: Ceguera bilateral / hemianopsia doble").tag(3)
                }
                .pickerStyle(.menu)
                if let visual { Text("Puntaje 3: \(visual)").frame(maxWidth: .infinity, alignment: .center) }
            }

            // 4 Facial palsy
            Section("4. Paresia facial") {
                Picker("Debilidad facial", selection: pickerBinding($facialPalsy)) {
                    Text("Seleccione").tag(-1)
                    Text("0: Normal").tag(0)
                    Text("1: Leve (asimetría mínima)").tag(1)
                    Text("2: Parcial (paresia evidente)").tag(2)
                    Text("3: Completa (parálisis total)").tag(3)
                }
                .pickerStyle(.menu)
                if let facialPalsy { Text("Puntaje 4: \(facialPalsy)").frame(maxWidth: .infinity, alignment: .center) }
            }

            // 5a Motor arm left
            Section("5a. Motor brazo izquierdo") {
                Picker("Brazo izquierdo (10 seg)", selection: pickerBinding($motorArmLeft)) {
                    Text("Seleccione").tag(-1)
                    Text("0: Mantiene 10 seg").tag(0)
                    Text("1: Desciende antes de 10 seg, no toca cama").tag(1)
                    Text("2: Algo de esfuerzo contra gravedad").tag(2)
                    Text("3: Sin esfuerzo contra gravedad").tag(3)
                    Text("4: Sin movimiento").tag(4)
                }
                .pickerStyle(.menu)
                if let motorArmLeft { Text("Puntaje 5a: \(motorArmLeft)").frame(maxWidth: .infinity, alignment: .center) }
            }

            // 5b Motor arm right
            Section("5b. Motor brazo derecho") {
                Picker("Brazo derecho (10 seg)", selection: pickerBinding($motorArmRight)) {
                    Text("Seleccione").tag(-1)
                    Text("0: Mantiene 10 seg").tag(0)
                    Text("1: Desciende antes de 10 seg, no toca cama").tag(1)
                    Text("2: Algo de esfuerzo contra gravedad").tag(2)
                    Text("3: Sin esfuerzo contra gravedad").tag(3)
                    Text("4: Sin movimiento").tag(4)
                }
                .pickerStyle(.menu)
                if let motorArmRight { Text("Puntaje 5b: \(motorArmRight)").frame(maxWidth: .infinity, alignment: .center) }
            }

            // 6a Motor leg left
            Section("6a. Motor pierna izquierda") {
                Picker("Pierna izquierda (5 seg)", selection: pickerBinding($motorLegLeft)) {
                    Text("Seleccione").tag(-1)
                    Text("0: Mantiene 5 seg").tag(0)
                    Text("1: Desciende antes de 5 seg, no toca cama").tag(1)
                    Text("2: Algo de esfuerzo contra gravedad").tag(2)
                    Text("3: Sin esfuerzo contra gravedad").tag(3)
                    Text("4: Sin movimiento").tag(4)
                }
                .pickerStyle(.menu)
                if let motorLegLeft { Text("Puntaje 6a: \(motorLegLeft)").frame(maxWidth: .infinity, alignment: .center) }
            }

            // 6b Motor leg right
            Section("6b. Motor pierna derecha") {
                Picker("Pierna derecha (5 seg)", selection: pickerBinding($motorLegRight)) {
                    Text("Seleccione").tag(-1)
                    Text("0: Mantiene 5 seg").tag(0)
                    Text("1: Desciende antes de 5 seg, no toca cama").tag(1)
                    Text("2: Algo de esfuerzo contra gravedad").tag(2)
                    Text("3: Sin esfuerzo contra gravedad").tag(3)
                    Text("4: Sin movimiento").tag(4)
                }
                .pickerStyle(.menu)
                if let motorLegRight { Text("Puntaje 6b: \(motorLegRight)").frame(maxWidth: .infinity, alignment: .center) }
            }

            // 7 Limb ataxia
            Section("7. Ataxia de miembros") {
                Picker("Ataxia", selection: pickerBinding($limbAtaxia)) {
                    Text("Seleccione").tag(-1)
                    Text("0: Ausente").tag(0)
                    Text("1: En un miembro").tag(1)
                    Text("2: En dos miembros").tag(2)
                }
                .pickerStyle(.menu)
                if let limbAtaxia { Text("Puntaje 7: \(limbAtaxia)").frame(maxWidth: .infinity, alignment: .center) }
            }

            // 8 Sensory
            Section("8. Sensibilidad") {
                Picker("Déficit sensitivo", selection: pickerBinding($sensory)) {
                    Text("Seleccione").tag(-1)
                    Text("0: Normal").tag(0)
                    Text("1: Leve-moderado").tag(1)
                    Text("2: Severo / anestesia").tag(2)
                }
                .pickerStyle(.menu)
                if let sensory { Text("Puntaje 8: \(sensory)").frame(maxWidth: .infinity, alignment: .center) }
            }

            // 9 Language
            Section("9. Lenguaje (Afasia)") {
                Picker("Afasia", selection: pickerBinding($language)) {
                    Text("Seleccione").tag(-1)
                    Text("0: Normal").tag(0)
                    Text("1: Afasia leve-moderada").tag(1)
                    Text("2: Afasia severa").tag(2)
                    Text("3: Mudo / afasia global").tag(3)
                }
                .pickerStyle(.menu)
                if let language { Text("Puntaje 9: \(language)").frame(maxWidth: .infinity, alignment: .center) }
            }

            // 10 Dysarthria
            Section("10. Disartria") {
                Picker("Disartria", selection: pickerBinding($dysarthria)) {
                    Text("Seleccione").tag(-1)
                    Text("0: Normal").tag(0)
                    Text("1: Leve-moderada").tag(1)
                    Text("2: Severa / ininteligible o mudo").tag(2)
                }
                .pickerStyle(.menu)
                if let dysarthria { Text("Puntaje 10: \(dysarthria)").frame(maxWidth: .infinity, alignment: .center) }
            }

            // 11 Extinction/Inattention
            Section("11. Extinción / Desatención") {
                Picker("Negligencia", selection: pickerBinding($extinctionInattention)) {
                    Text("Seleccione").tag(-1)
                    Text("0: Ausente").tag(0)
                    Text("1: Leve").tag(1)
                    Text("2: Severa").tag(2)
                }
                .pickerStyle(.menu)
                if let extinctionInattention { Text("Puntaje 11: \(extinctionInattention)").frame(maxWidth: .infinity, alignment: .center) }
            }

            // Total and clear button
            Section("Total") {
                if let total {
                    Text("NIHSS: \(total)")
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity, alignment: .center)
                } else {
                    Text("Complete todos los ítems para ver el total")
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                Button("Limpiar selecciones", role: .destructive) {
                    clearAll()
                }
            }
        }
        .navigationTitle("Escala NIHSS")
    }

    private func clearAll() {
        loc = nil; locQuestions = nil; locCommands = nil
        gaze = nil; visual = nil; facialPalsy = nil
        motorArmLeft = nil; motorArmRight = nil
        motorLegLeft = nil; motorLegRight = nil
        limbAtaxia = nil; sensory = nil
        language = nil; dysarthria = nil
        extinctionInattention = nil
    }
}

#Preview {
    NavigationStack { NIHSSView() }
}
