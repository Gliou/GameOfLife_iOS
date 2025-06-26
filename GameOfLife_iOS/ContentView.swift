
import SwiftUI

struct ContentView: View {
    @StateObject private var game = GameLogic()

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)

            VStack {
                Text("Game of Life")
                    .font(.largeTitle)
                    .foregroundColor(.green)
                    .padding()

                GridView(grid: game.grid)

                HStack(spacing: 20) {
                    Button("Start") {
                        game.start()
                    }
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.black)
                    .cornerRadius(10)

                    Button("Stop") {
                        game.stop()
                    }
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.black)
                    .cornerRadius(10)

                    Button("Reset") {
                        game.reset()
                    }
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.black)
                    .cornerRadius(10)
                }
                .padding()
            }
        }
    }
}

struct GridView: View {
    let grid: [[Bool]]

    var body: some View {
        VStack(spacing: 1) {
            ForEach(0..<grid.count, id: \.self) { row in
                HStack(spacing: 1) {
                    ForEach(0..<self.grid[row].count, id: \.self) { col in
                        Rectangle()
                            .fill(self.grid[row][col] ? Color.red : Color.white)
                            .frame(width: 7, height: 7) // Smaller cells for iPhone
                    }
                }
            }
        }
        .border(Color.green)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
