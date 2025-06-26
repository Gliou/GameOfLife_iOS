
import Foundation

class GameLogic: ObservableObject {
    @Published var grid: [[Bool]]
    private var timer: Timer?

    private let rows = 30
    private let cols = 50

    init() {
        self.grid = Array(repeating: Array(repeating: false, count: cols), count: rows)
        reset()
    }

    func start() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.005, repeats: true) { _ in
            self.nextGeneration()
        }
    }

    func stop() {
        timer?.invalidate()
        timer = nil
    }

    func reset() {
        // Clear the grid
        for r in 0..<rows {
            for c in 0..<cols {
                grid[r][c] = false
            }
        }

        // Add glider 1
        grid[14][2] = true
        grid[15][3] = true
        grid[16][1] = true
        grid[16][2] = true
        grid[16][3] = true

/*        // Add glider 2
        grid[10][12] = true
        grid[11][13] = true
        grid[12][11] = true
        grid[12][12] = true
        grid[12][13] = true
 */
    }

    private func nextGeneration() {
        var newGrid = grid

        for row in 0..<rows {
            for col in 0..<cols {
                let neighbors = countNeighbors(row: row, col: col)
                let cell = grid[row][col]

                if cell && (neighbors < 2 || neighbors > 3) {
                    newGrid[row][col] = false
                } else if !cell && neighbors == 3 {
                    newGrid[row][col] = true
                }
            }
        }

        grid = newGrid
    }

    private func countNeighbors(row: Int, col: Int) -> Int {
        var count = 0
        for i in -1...1 {
            for j in -1...1 {
                if i == 0 && j == 0 { continue }

                let newRow = (row + i + rows) % rows
                let newCol = (col + j + cols) % cols

                if grid[newRow][newCol] {
                    count += 1
                }
            }
        }
        return count
    }
}
