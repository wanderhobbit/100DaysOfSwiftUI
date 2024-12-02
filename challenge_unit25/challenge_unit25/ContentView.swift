//
//  ContentView.swift
//  challenge_unit25
//
//  Created by Wander.Hobbit on 12/2/24.
//


import SwiftUI

struct ContentView: View {
    @State private var countries = ["Rock", "Paper", "Scissors"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0

    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct!"
            score += 1
        } else {
            scoreTitle = "Wrong! That's the flag for \(countries[number])."
        }
        showingScore = true
    }
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    var body: some View {

        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.12, blue: 0.145), location: 0.3),
                .init(color: Color(red: 0.376, green: 0.215, blue: 0.26), location: 0.3),
            ], center: .center, startRadius: 10, endRadius: 800)
                .ignoresSafeArea()
            VStack(spacing: 15) {
                VStack {
                    Spacer()
                    Text("Rock, Paper, Scissors")
                        .font(.largeTitle.weight(.bold))
                        .foregroundStyle(.white)
                    Spacer()
                    Spacer()
                    Text("Score: \(score)")
                        .foregroundStyle(.white)
                        .font(.title.bold())
                    // current VStack(spacing: 15) code
                    Spacer()
                }
                VStack {
                    Text("Tap the flag of")
                        .font(.subheadline.weight(.heavy))
                        .foregroundStyle(.secondary)
                    Text(countries[correctAnswer])
                        .font(.largeTitle.weight(.semibold))
                        .foregroundStyle(.white)
                }
                
                ForEach(0..<3) { number in
                    Button {
                        flagTapped(number)
                    } label: {
                        Image(countries[number])
                            .clipShape(.capsule)
                            .shadow(radius: 5)
                    }
                    
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 40)
            .background(.regularMaterial)
            .clipShape(.rect(cornerRadius: 20))
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
    }
}

#Preview {
    ContentView()
}
