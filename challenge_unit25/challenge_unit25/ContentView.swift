import SwiftUI

struct ContentView: View {
    let moves = ["✊", "✋", "✌️"] // Rock, Paper, Scissors emojis
    
    @State private var appMove = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    
    @State private var score = 0
    @State private var round = 1
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""

    func handlePlayerMove(_ playerMove: Int) {
        let winCondition: Bool
        
        if shouldWin {
            winCondition = playerMove == (appMove + 1) % 3 // Player must win
        } else {
            winCondition = playerMove == (appMove + 2) % 3 // Player must lose
        }
        
        if winCondition {
            score += 1
            alertTitle = "Correct!"
        } else {
            // score -= 1
            alertTitle = "Wrong!"
        }
        
        //alertMessage = "App chose \(moves[appMove]). You were asked to \(shouldWin ? "Win" : "Lose")."
        
        showingAlert = true
    }
    
    func nextRound() {
        if round == 10 {
            alertTitle = "Game Over"
            alertMessage = "Your final score is \(score)."
            showingAlert = true
            round = 0
            score = 0
        } else {
            appMove = Int.random(in: 0...2)
            shouldWin = Bool.random()
            round += 1
        }
    }

    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.12, blue: 0.145), location: 0.1),
                .init(color: Color(red: 0.376, green: 0.215, blue: 0.26), location: 0.8),
            ], center: .center, startRadius: 10, endRadius: 500)
            .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Spacer()

                Text("Rock, Paper, Scissors")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()
                Spacer()
                
                VStack {
                    Text("App chose: \(moves[appMove])")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                    
                    Text("Your goal: ")
                        .foregroundStyle(.white)
                    +
                    Text(shouldWin ? "Win" : "Lose")
                        .foregroundColor(shouldWin ? .green : .red)
                        .font(.title2.bold())
                }
                
                Spacer()
                
                HStack(spacing: 20) {
                    ForEach(0..<3) { index in
                        Button {
                            handlePlayerMove(index)
                        } label: {
                            Text(moves[index])
                                .font(.system(size: 40))
                                .padding()
                                .background(.ultraThinMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                    
                }
                
                Text("Round: \(round)/10")
                    .foregroundStyle(.white)
                    .font(.title2)
                
                Spacer()
                Spacer()

                
            }
            .padding()
        }
        .alert(alertTitle, isPresented: $showingAlert) {
            Button("Next", action: nextRound)
        } message: {
            Text(alertMessage)
        }
    }
}

#Preview {
    ContentView()
}
