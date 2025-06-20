import Foundation

class Player: Identifiable, ObservableObject {
    let id = UUID()
    let name: String
    @Published var score: Int

    init(name: String) {
        self.name = name
        self.score = 0
    }
}

class BoggleGame: ObservableObject {
    @Published var board: [[String]] = []
    @Published var remainingSeconds: Int = 120
    @Published var isRunning: Bool = false

    var timer: Timer?
    var players: [Player] = [Player(name: "Player 1"), Player(name: "Player 2")]

    func startGame() {
        board = BoggleDice.roll()
        remainingSeconds = 120
        isRunning = true
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.tick()
        }
    }

    func tick() {
        guard remainingSeconds > 0 else {
            timer?.invalidate()
            isRunning = false
            return
        }
        remainingSeconds -= 1
    }

    func addScore(for playerIndex: Int, points: Int) {
        players[playerIndex].score += points
    }

    func resetScores() {
        players.forEach { $0.score = 0 }
    }
}
