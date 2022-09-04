//
//  NewGameView.swift
//  Milestone1
//
//  Created by admin on 02.09.2022.
//

import SwiftUI

struct NewGameView: View {
    let color = Color(red: 0.85, green: 0.7, blue: 0.45)

    @Binding var gameMode: Bool
    let gameMoves = ["Rock", "Paper", "Scissors"]
    
    @State private var playerOneMove = ""
    @State private var playerTwoMove = ""
    
    @State private var playerOneScore = 0
    @State private var playerTwoScore = 0
    
    @State private var playerOneSubmited = false
    @State private var playerTwoSubmited = false
    
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            color
                .ignoresSafeArea()
            if gameMode { // if vs other player
                VStack(spacing: 20) {
                    HStack {
                        ForEach(gameMoves, id: \.self) { key in
                            Button {
                                withAnimation(.easeInOut(duration: 1).delay(0.1)) {
                                    playerOneMove = key
                                    playerOneSubmited = true
                                }
                                
                            } label: {
                                Text(setButtonLabel(key:key))
                                
                            }
                            .blur(radius: playerTwoSubmited || !playerOneSubmited ? 0 : 1.2)
                            .padding()
                            .background(.ultraThinMaterial)
                            .cornerRadius(15)
                            .opacity(playerTwoSubmited || !playerOneSubmited ? 1 : 0.6)
                            }
                    }
                    .font(.system(size: 70))
                    .disabled(playerOneSubmited ? true : false)
                    
                    Button {
                        
                        chechSubmition(resultOne: playerOneMove, resultTwo: playerTwoMove)
                    } label: {
                        Text(labelText()) // changes text and action on conditions
                    }
                    .foregroundColor(.secondary)
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(.ultraThinMaterial)
                    
                    HStack {
                        ForEach(gameMoves, id: \.self) { key in
                            Button {
                                withAnimation(.easeInOut(duration: 1).delay(0.1)) {
                                    playerTwoMove = key
                                    playerTwoSubmited = true
                                }
                                
                            } label: {
                                Text(setButtonLabel(key:key))
                            }
                            .blur(radius: playerOneSubmited ? 0 : 1.2)
                            .padding()
                            .background(.ultraThinMaterial)
                            .cornerRadius(15)
                            .opacity(playerOneSubmited ? 1 : 0.6)
                        }
                    }
                    .font(.system(size: 70))
                    .disabled(playerTwoSubmited || !playerOneSubmited ? true : false)
                    
                }
            } else { // if vs computer
                VStack {
                    HStack {
                        ForEach(gameMoves, id: \.self) { key in
                            Button {
                                withAnimation(.easeInOut(duration: 1).delay(0.1)) {
                                    playerOneMove = key
                                    playerOneSubmited = true
                                }
                            } label: {
                                Text(setButtonLabel(key:key))
                            }
                            .padding()
                            .background(.ultraThinMaterial)
                            .cornerRadius(15)
                        }
                    }
                    .font(.system(size: 50))
                    Button {
                        withAnimation {
                            vsComputer(resultOne: playerOneMove)
                        }
                    } label: {
                        Text(playerOneSubmited ? "compare." : "pick your move.") // changes text and action on conditions
                    }
                    .foregroundColor(.secondary)
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(.ultraThinMaterial)
                    
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .alert(alertTitle, isPresented: $showingAlert) {
            Button("Continue", role: .cancel) {
                dismiss()
            }
        } message: {
            Text(alertMessage)
        }
    }
    func chechSubmition(resultOne: String, resultTwo: String) {
            if playerOneSubmited && playerTwoSubmited {
                withAnimation {
                    compare(first: resultOne, second: resultTwo)
                    playerOneSubmited = false
                    playerTwoSubmited = false

                }
            }
        presentAlert()
    }
    func vsComputer(resultOne: String) {
        let computerMove = gameMoves.randomElement() ?? ""
        compare(first: resultOne, second: computerMove)
        playerOneSubmited = false
        playerTwoSubmited = false
        presentAlert()
    }
    func presentAlert() {
        if playerOneScore + playerTwoScore == 3 {
            showingAlert = true
            alertTitle = "We have a winner"
            if playerOneScore > playerTwoScore {
                alertMessage = "Player One is a winner with a score: \(playerOneScore)."
            } else {
                if gameMode {
                    alertMessage = "Player Two is a winner with a score: \(playerOneScore)."
                } else {
                    alertMessage = "Computer is a winner with a score: \(playerOneScore)."
                }            }
        }
    }
    func labelText() -> String{
        var text = ""
        if !playerOneSubmited {
            text = "player one moves."
        } else if !playerTwoSubmited && playerOneSubmited {
            text = "player two moves."
        } else if playerOneSubmited && playerTwoSubmited {
            text = "compare."
        }
        return text
    }
    func compare(first resultOne: String, second resultTwo: String) {
        switch resultOne {
        case "Rock":
            switch resultTwo {
            case "Rock":
                print("draw")
            case "Paper":
                playerTwoScore += 1
                print("player 2 wins")
            default:
                playerOneScore += 1
                print("player 1 wins")
            }
        case "Paper":
            switch resultTwo {
            case "Rock":
                playerOneScore += 1
                print("player 1 wins")
            case "Paper":
                print("draw")
            default:
                playerTwoScore += 1
                print("player 2 wins")
            }
        default:
            switch resultTwo {
            case "Rock":
                playerTwoScore += 1
                print("player 2 wins")
            case "Paper":
                playerOneScore += 1
                print("player 1 wins")
            default:
                print("draw")
            }
        }
    }
    func setButtonLabel(key: String) -> String {
        var label = ""
        switch key {
        case "Rock":
            label = "✊"
        case "Paper":
            label = "🤚"
        default:
            label = "✌️"
        }
        return label
    }
}

//struct NewGameView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewGameView()
//    }
//}
