//
//  ContentView.swift
//  Memorize6
//
//  Created by Xiao Hu on 31/08/2022.
//

import SwiftUI

struct MemorizeView: View {
    @ObservedObject var game: MemorizeViewModel
    
    var body: some View {
       gameBody
    }
    
    var gameBody: some View {
        VStack {
            Text("Score: \(game.score)")
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))]) {
                    ForEach(game.cards) { card in
                        if card.isMatched && !card.isFaceUp {
                            withAnimation {
                                Rectangle().opacity(0)
                            }
                        } else {
                            CardView(card: card)
                                .aspectRatio(2/3, contentMode: .fit)
                                .onTapGesture {
                                    withAnimation {
                                        game.choose(card: card)
                                    }
                                }
                        }
                    }
                }
                .padding()
            }
            .foregroundColor(Color(rgbaColor: game.chosenTheme.color))
        }
        .padding()
        .navigationTitle("\(game.chosenTheme.name)!")
        .toolbar {
            newGameButton
        }
    }
    
    var newGameButton: some View {
        Button {
            game.newGame()
        } label: {
            Text("New Game")
        }
    }
}

struct MemoirzeView_Previews: PreviewProvider {
    static var previews: some View {
        MemorizeView(game: MemorizeViewModel(theme: ThemeStore(named: "default").theme(at: 4)))
    }
}
