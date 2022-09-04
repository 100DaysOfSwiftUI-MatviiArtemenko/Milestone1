//
//  ContentView.swift
//  Milestone1
//
//  Created by admin on 02.09.2022.
//

import SwiftUI


struct ContentView: View {
    @State private var gameMode = false
    let color = Color(red: 0.85, green: 0.7, blue: 0.45)
    var body: some View {
        NavigationView {
            ZStack {
                color
                    .ignoresSafeArea()
                VStack {
                    NavigationLink {
                        NewGameView(gameMode: $gameMode)
                    } label: {
                        Text("Start new game.")
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(10)
                    .padding()
                    HStack {
                        Button {
                            withAnimation {
                                gameMode.toggle()
                            }
                            
                        } label: {
                            Image(systemName: modeIcon())
                            
                        }
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(10)
                    .padding()
                    
                }
                .padding()
                .padding(.vertical)
                .background(.ultraThinMaterial)
                .cornerRadius(15)
                .foregroundColor(.secondary)
                .font(.title2)
                
                
            }
            .navigationTitle("RockPaperScissors.")

        }
    }
    func modeIcon() -> String {
        withAnimation {
            if !gameMode {
                return "person.fill"
            } else {
                return "person.2.fill"
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
