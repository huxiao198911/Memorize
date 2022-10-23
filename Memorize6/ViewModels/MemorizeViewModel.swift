//
//  MemorizeViewModel.swift
//  Memorize6
//
//  Created by Xiao Hu on 31/08/2022.
//

import SwiftUI

class MemorizeViewModel: ObservableObject {
    @Published private var memorize: MemorizeModel<String>
    
    var chosenTheme: Theme
    
    init(theme: Theme) {
        chosenTheme = theme
        memorize = MemorizeViewModel.createMemorizeModel(for: chosenTheme)
    }
    
    static func createMemorizeModel(for theme: Theme) -> MemorizeModel<String> {
        let emojis = theme.emojis.map { String($0) }.shuffled()
        return MemorizeModel(numberOfPairedCards: theme.numbeOfPairedCards) { index in
            emojis[index]
        }
    }
    
    var cards: [MemorizeModel<String>.Card] {
        memorize.cards
    }
    
    var score: Int {
        memorize.score
    }
    
    
    // MARK: Intents
    func choose(card: MemorizeModel<String>.Card) {
        memorize.choose(card: card)
    }
    
    func newGame() {
        memorize.score = 0
        memorize = MemorizeViewModel.createMemorizeModel(for: chosenTheme)
    }
}
