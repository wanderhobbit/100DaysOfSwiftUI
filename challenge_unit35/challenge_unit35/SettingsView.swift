//
//  SettingsView.swift
//  challenge_unit35
//
//  Created by Matthew Doll on 12/6/24.
//

import SwiftUI

struct SettingsView: View {
    @Binding var maxTable: Int
    @Binding var numberOfQuestions: Int
    
    var onStart: () -> Void
    
    let questionOptions = [5,10,20]
    
    var body: some View {
        Form {
            Section(header: Text("Multiplication Table Range")) {
                Stepper("Up to \(maxTable)", value: $maxTable, in: 2...12)
            }
            
            Section(header: Text("Number of Questions")) {
                Picker("Number of Questions", selection: $numberOfQuestions) {
                    ForEach(questionOptions, id: \.self) { option in
                        Text("\(option)")
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            Section {
                Button("Start Game") {
                    onStart()
                }
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .center)
            }
        }
    }
}
