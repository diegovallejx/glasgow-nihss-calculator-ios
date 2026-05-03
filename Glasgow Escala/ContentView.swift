//
//  ContentView.swift
//  Glasgow Escala
//
//  Created by Diego Vallejos Agüero on 26-02-26.
//

import SwiftUI

struct ContentView: View {
    @State private var ocular: Int? = nil
    @State private var verbal: Int? = nil
    @State private var motora: Int? = nil

    @State private var showAirwayAlert: Bool = false
    @State private var goToNIHSS: Bool = false

    private var ocularSelection: Binding<Int> {
        Binding(
            get: { ocular ?? -1 },
            set: { newValue in ocular = (newValue == -1) ? nil : newValue }
        )
    }

    private var verbalSelection: Binding<Int> {
        Binding(
            get: { verbal ?? -1 },
            set: { newValue in verbal = (newValue == -1) ? nil : newValue }
        )
    }

    private var motoraSelection: Binding<Int> {
        Binding(
            get: { motora ?? -1 },
            set: { newValue in motora = (newValue == -1) ? nil : newValue }
        )
    }

    private var interpretacion: String? {
        guard let total else { return nil }
        switch total {
        case 13...15: return "Leve (13–15)"
        case 9...12: return "Moderado (9–12)"
        case ...8: return "Severo (≤8)"
        default: return nil
        }
    }

    private var total: Int? {
        guard let ocular = ocular, let verbal = verbal, let motora = motora else { return nil }
        let sum: Int = ocular + verbal + motora
        return sum
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Form {
                    Section("Respuesta ocular (E)") {
                        Picker("Respuesta ocular", selection: ocularSelection) {
                            Text("Seleccione").tag(-1)
                            Text("4: Espontánea").tag(4)
                            Text("3: Al hablar").tag(3)
                            Text("2: Al dolor").tag(2)
                            Text("1: No responde").tag(1)
                        }
                        .pickerStyle(.menu)
                        if let ocular { Text("Puntaje E: \(ocular)").multilineTextAlignment(.center).frame(maxWidth: .infinity, alignment: .center) }
                    }

                    Section("Respuesta verbal (V)") {
                        Picker("Respuesta verbal", selection: verbalSelection) {
                            Text("Seleccione").tag(-1)
                            Text("5: Orientado").tag(5)
                            Text("4: Confuso").tag(4)
                            Text("3: Palabras inapropiadas").tag(3)
                            Text("2: Sonidos incomprensibles").tag(2)
                            Text("1: No responde").tag(1)
                        }
                        .pickerStyle(.menu)
                        if let verbal { Text("Puntaje V: \(verbal)").multilineTextAlignment(.center).frame(maxWidth: .infinity, alignment: .center) }
                    }

                    Section("Respuesta motora (M)") {
                        Picker("Respuesta motora", selection: motoraSelection) {
                            Text("Seleccione").tag(-1)
                            Text("6: Obedece órdenes").tag(6)
                            Text("5: Localiza el dolor").tag(5)
                            Text("4: Retira ante el dolor").tag(4)
                            Text("3: Flexión anormal (decorticación)").tag(3)
                            Text("2: Extensión anormal (descerebración)").tag(2)
                            Text("1: No responde").tag(1)
                        }
                        .pickerStyle(.menu)
                        if let motora { Text("Puntaje M: \(motora)").multilineTextAlignment(.center).frame(maxWidth: .infinity, alignment: .center) }
                    }

                    Section("Total") {
                        if let total {
                            let e = ocular ?? 0
                            let v = verbal ?? 0
                            let m = motora ?? 0
                            Text("GCS: \(total) (E \(e), V \(v), M \(m))")
                                .font(.headline)
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity, alignment: .center)
                            if let interpretacion {
                                Text("Interpretación: \(interpretacion)")
                                    .multilineTextAlignment(.center)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .foregroundStyle(.secondary)
                            }
                        } else {
                            Text("Seleccione todas las respuestas para ver el total")
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .foregroundStyle(.secondary)
                        }
                        Button("Limpiar selecciones", role: .destructive) {
                            ocular = nil; verbal = nil; motora = nil
                        }
                    }
                }
            }
            .navigationTitle("Escala de Glasgow")
            .onChange(of: total) { _, newValue in
                if let value = newValue, value <= 8 {
                    showAirwayAlert = true
                }
            }
            .alert("", isPresented: $showAirwayAlert, actions: {
                Button("OK", role: .cancel) { showAirwayAlert = false }
            }, message: {
                Text("⚠️ Glasgow ≤ 8 ⚠️\nConsidere proteger vía aérea")
                    .multilineTextAlignment(.center)
            })
            .simultaneousGesture(
                DragGesture(minimumDistance: 20, coordinateSpace: .local)
                    .onEnded { value in
                        let isHorizontal = abs(value.translation.width) > abs(value.translation.height)
                        if isHorizontal && value.translation.width > 50 {
                            goToNIHSS = true
                        }
                    }
            )
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("NIHSS") { goToNIHSS = true }
                }
            }
            .navigationDestination(isPresented: $goToNIHSS) {
                NIHSSView()
            }
        }
    }
}

#Preview {
    ContentView()
}

