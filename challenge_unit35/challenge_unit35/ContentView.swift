//
//  ContentView.swift
//  challenge_unit35
//
//  Created by Matthew Doll on 12/6/24.
//

import SwiftUI


struct ContentView: View {
    @State private var showingSettings = true
    
    // Game settings
    @State private var maxTable = 2
    @State private var numberOfQuestions = 5
    
    // Game state
    @State private var questions: [Question] = []
    @State private var currentQuestionIndex = 0
    @State private var score = 0
    @State private var gameOver = false
    
    var body: some View {
        NavigationView {
            Group {
                if showingSettings {
                    SettingsView(
                        maxTable: $maxTable,
                        numberOfQuestions: $numberOfQuestions
                    ) {
                        startGame()
                    }
                } else {
                    GameView(
                        questions: questions,
                        currentIndex: currentQuestionIndex,
                        score: score,
                        onAnswer: handleAnswer,
                        onPlayAgain: resetGame,
                        isGameOver: gameOver
                    )
                }
            }
            .navigationTitle("Edutainment")
        }
    }
    
    func startGame() {
        // Generate questions
        questions = generateQuestions(upTo: maxTable, count: numberOfQuestions)
        currentQuestionIndex = 0
        score = 0
        gameOver = false
        showingSettings = false
    }
    
    func handleAnswer(_ userAnswer: Int) {
        let currentQuestion = questions[currentQuestionIndex]
        if userAnswer == currentQuestion.answer {
            score += 1
        }
        
        if currentQuestionIndex == questions.count - 1 {
            // Game finished
            gameOver = true
        } else {
            currentQuestionIndex += 1
        }
    }
    
    func resetGame() {
        showingSettings = true
    }
    
    func generateQuestions(upTo: Int, count: Int) -> [Question] {
        var generated: [Question] = []
        for _ in 1...count {
            let a = Int.random(in: 1...upTo)
            let b = Int.random(in: 1...upTo)
            generated.append(Question(text: "What is \(a) x \(b)?", answer: a * b))
        }
        return generated.shuffled()
    }
}

#Preview {
    ContentView()
}
