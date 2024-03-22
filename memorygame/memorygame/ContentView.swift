//
//  ContentView.swift
//  memorygame
//
//  Created by StudentAM on 3/12/24.
//

import SwiftUI

struct ContentView: View {
    @State private var score = 0 // State variable to hold the score
    @State private var emojis = ["😀", "😀" ,"😁", "😁", "😂", "😂", "🤣", "🤣", "😃", "😃", "😄", "😄"].shuffled()
    @State private var flippedCards: Set<Int> = [] // Track flipped cards
    @State var cardsFlipped: [Bool] = Array(repeating: false, count: 16)
    @State private var matchedCards: Set<Int> = [] // Track matched cards
    
    
    let customLightPink = Color(red: 255/255, green: 192/255, blue: 203/255)
    let customLimeGreen = Color(red: 206/255, green: 250/255, blue: 95/255)
    

    var body: some View {
        
            // Circles for background
            
            Group {
                    if score < 6 {
                        
                        
            VStack {
                Spacer() // Move the score down
                    .frame(height: 70) // Adjust the height as needed
                Circle()
                    .fill(customLightPink)
                    .frame(width: 350, height: 350)
                    .position(x: 50, y: -40)
                
                Circle()
                    .fill(customLimeGreen)
                    .frame(width: 350, height: 350)
                    .position(x: UIScreen.main.bounds.width - 50, y: UIScreen.main.bounds.height - 180)
            
                Text("Current Score: \(score)") // Display the score
                    .font(.title)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .padding(.top, 20)
                
                LazyVGrid(columns: Array(repeating: GridItem(), count: 3)) {
                    ForEach(emojis.indices, id: \.self) { index in
                        CardView(
                            emoji: emojis[index],
                            isFlipped: flippedCards.contains(index),
                            isMatched: matchedCards.contains(index) // Pass whether the card is matched
                        )
                        .onTapGesture {
                            withAnimation {
                                toggleCard(index)
                            }
                        }
                    }

                }
                
                
                HStack {
                    Spacer()
                    
                    Button("Retry") {
                        resetGame()
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(6)
                    
                    Spacer()
                    
                    Button("Next") {
                        // Implement action for the "Next" button here
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(6)
                    
                    Spacer()
                        
                }
                .padding()
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.white)
                    } else {
                        VStack {
            
                            Text("😃")
                                .font(.system(size: 100))
                                .padding()
                            
                            Text("Great Job!")
                                .font(.largeTitle)
                                .padding()

                            Button("Play Again") {
                                resetGame()
                            }
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(6)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.white)
            
        }
               }
            }
    
                
    private func toggleCard(_ index: Int) {
        // Check if the selected card is already flipped or matched (to ignore clicks on these cards)
        if flippedCards.contains(index) || matchedCards.contains(index) {
            return
        }

        // Flip the current card
        flippedCards.insert(index)
        
        // Check if two cards are flipped
        if flippedCards.count % 2 == 0 {
            let flippedIndexes = Array(flippedCards)
            
            // Check for a match
            if emojis[flippedIndexes[0]] == emojis[flippedIndexes[1]] {
                // Matching emojis found, increment score
                score += 1
                // Add these cards to the matched set
                matchedCards.formUnion(flippedIndexes)
                // Remove them from the flipped set
                flippedCards.subtract(flippedIndexes)
            } else {
                // If the two flipped cards don't match, flip them back after a delay
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    // Only reset cards that are not matched
                    self.flippedCards.subtract(flippedIndexes.filter { !self.matchedCards.contains($0) })
                }
            }
        }
    }

    
    
                
                private func resetGame() {
                    
                    score = 0
                    
                    flippedCards.removeAll()
                    matchedCards.removeAll()
                    
                    emojis.shuffle()
                }
            }

    
struct CardView: View {
    let emoji: String
    let isFlipped: Bool
    let isMatched: Bool  // Add this to track if the card is matched

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .fill(Color.blue)
                .aspectRatio(1, contentMode: .fit)
                .padding(13)
                .opacity(isFlipped || isMatched ? 0 : 1) // Hide the blue square if the card is flipped or matched

            if isFlipped || isMatched {
                Text(emoji)
                    .font(.largeTitle)
            }
        }
    }
}




#Preview {
    ContentView()
}
