//
//  Game.swift
//  
//
//  Created by StudentAM on 3/11/24.
//

import SwiftUI

struct Game: View {
    var body: some View {
        NavigationView {
            ZStack {
                Image("Image")
                
                VStack {
                    Spacer()
                    Text("EmojiMatch")
                        .font(.system(size: 52)) // Increased font size
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(10)
                        
                    
                    Spacer()
                    
                    NavigationLink(destination: ContentView()) {
                        Text("Start")
                            .font(.system(size: 53)) // Increased font size
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                            
                    }
                    .padding()
                    
                    Spacer()
                }
                .padding()
            }
        }
    }
}

#Preview {
    Game()
}
