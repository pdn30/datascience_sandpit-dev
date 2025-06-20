import SwiftUI

struct ContentView: View {
    @StateObject var game = BoggleGame()

    let columns = Array(repeating: GridItem(.flexible()), count: 4)

    var body: some View {
        VStack {
            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(0..<4, id: .self) { i in
                    ForEach(0..<4, id: .self) { j in
                        Text(game.board.indices.contains(i) ? game.board[i][j] : "")
                            .frame(width: 50, height: 50)
                            .background(Color.blue.opacity(0.2))
                            .cornerRadius(4)
                    }
                }
            }
            .padding()

            Text("Time Remaining: \(game.remainingSeconds)s")
                .font(.headline)
                .padding()

            HStack {
                ForEach(Array(game.players.enumerated()), id: .element.id) { index, player in
                    VStack {
                        Text(player.name)
                        Text("Score: \(player.score)")
                    }
                    .padding()
                }
            }

            HStack {
                Button("Start Game") {
                    game.startGame()
                }
                .padding()

                Button("Reset Scores") {
                    game.resetScores()
                }
                .padding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
