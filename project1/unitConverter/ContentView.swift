//
//  ContentView.swift
//  Unit Converter
//
//  Created by Wander Hobbit on 11/22/24.
//

import SwiftUI

struct ContentView: View {
    @State private var inValue: String = ""
    @State private var inUnit: String
    @State private var outUnit: String

    @FocusState private var amountIsFocused: Bool

    let units = ["Celsius", "Fahrenheit", "Kelvin"]

    init() {
        // Initialize inUnit and outUnit with the first two units
        self._inUnit = State(initialValue: units[0])
        self._outUnit = State(initialValue: units[1])
    }
    
    func convert(value: Double, from input: String, to output: String) -> Double {
        // Convert the input value to Celsius as a base
        let celsiusValue: Double
        switch input {
        case "Fahrenheit":
            celsiusValue = (value - 32) * 5 / 9
        case "Kelvin":
            celsiusValue = value - 273.15
        default: // "Celsius"
            celsiusValue = value
        }
        
        // Convert from Celsius to the desired output unit
        switch output {
        case "Fahrenheit":
            return celsiusValue * 9 / 5 + 32
        case "Kelvin":
            return celsiusValue + 273.15
        default: // "Celsius"
            return celsiusValue
        }
    }

    var convertedValue: Double {
        guard let input = Double(inValue) else { return 0.0 }
        return convert(value: input, from: inUnit, to: outUnit)
    }

    var body: some View {
        NavigationStack {
            Form {
                // Input Section
                Section(header: Text("Input")) {
                    HStack {
                        TextField("Input Value", text: $inValue)
                            .keyboardType(.decimalPad)
                            .focused($amountIsFocused)
                        
                        Picker("", selection: $inUnit) {
                            ForEach(units, id: \.self) { unit in
                                Text(unit)
                            }
                        }
                        .pickerStyle(.menu)
                    }
                }
                
                // Output Section
                Section(header: Text("Output")) {
                    HStack{
                        Text(String(convertedValue))
                        
                        Picker("", selection: $outUnit) {
                            ForEach(units, id: \.self) { unit in
                                Text(unit)
                            }
                        }
                        .pickerStyle(.menu)
                    }
                }
            }
            .navigationTitle("Unit Converter")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
