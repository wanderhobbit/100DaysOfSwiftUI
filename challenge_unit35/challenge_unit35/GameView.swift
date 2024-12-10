//
//  GameView.swift
//  challenge_unit35
//
//  Created by Matthew Doll on 12/6/24.
//


import SwiftUI

struct GameView: View {
    let questions: [Question]
    let currentIndex: Int
    let score: Int
    let onAnswer: (Int) -> Void
    let onPlayAgain: () -> Void
    let isGameOver: Bool
    
    @State private var userAnswer = ""
    @FocusState private var answerFieldFocused: Bool
    
    var body: some View {
        if isGameOver {
            VStack(spacing: 20) {
                Text("Game Over!")
                    .font(.largeTitle)
                Text("Your score: \(score)/\(questions.count)")
                    .font(.title)
                
                Button("Play Again") {
                    onPlayAgain()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        } else {
            VStack(spacing: 20) {
                Text("Question \(currentIndex + 1) of \(questions.count)")
                    .font(.headline)
                
                Text(questions[currentIndex].text)
                    .font(.largeTitle)
                
                TextField("Your Answer", text: $userAnswer)
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .focused($answerFieldFocused)
                
                Button("Submit") {
                    guard let answerInt = Int(userAnswer) else { return }
                    onAnswer(answerInt)
                    userAnswer = ""
                    answerFieldFocused = true
                }
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding()
            .onAppear {
                answerFieldFocused = true
            }
        }
    }
}