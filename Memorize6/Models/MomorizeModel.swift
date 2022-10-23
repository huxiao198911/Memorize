//
//  MomorizeModel.swift
//  Memorize6
//
//  Created by Xiao Hu on 31/08/2022.
//

import Foundation

struct MemorizeModel<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card] = []
    
    private var indexOfTheOneAndOnlyPairedCard: Int? {
        get {
            cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
        }
        set {
            cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue) }
        }
    }
    
    var score = 0
    
    init(numberOfPairedCards: Int, cardContent: (Int) -> CardContent) {
        for index in 0..<numberOfPairedCards {
            cards.append(Card(id: index * 2, content: cardContent(index)))
            cards.append(Card(id: index * 2 + 1, content: cardContent(index)))
        }
        cards.shuffle()
    }
    
    mutating func choose(card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !card.isMatched,
           !card.isFaceUp {
            if let potentialMatchedIndex = indexOfTheOneAndOnlyPairedCard {
                if cards[potentialMatchedIndex].content == cards[chosenIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchedIndex].isMatched = true
                    cards[chosenIndex].hasAlreadyBeenSeen = true
                    cards[potentialMatchedIndex].hasAlreadyBeenSeen = true
                    score += 5
                } else if  cards[chosenIndex].hasAlreadyBeenSeen || cards[potentialMatchedIndex].hasAlreadyBeenSeen {
                    score -= 2
                }
                cards[chosenIndex].isFaceUp = true
            } else {
                for index in cards.indices {
                    if cards[index].isFaceUp {
                        cards[index].isFaceUp = false
                        cards[index].hasAlreadyBeenSeen = true
                    }
                }
                indexOfTheOneAndOnlyPairedCard = chosenIndex
            }
        }
    }
    
    //    enum CardState {
    //        case initial
    //        case faceup
    //        case matched
    //        case hasAlreadyBeenSeen
    //    }
    
    struct Card: Identifiable {
        var id: Int
        var isFaceUp = false
//        {
//            didSet {
//                if isFaceUp {
//                    startUsingBonusTime()
//                } else {
//                    stopUsingBonusTime()
//                }
//            }
//        }
        var isMatched = false
//        {
//            didSet {
//                stopUsingBonusTime()
//            }
//        }
        var hasAlreadyBeenSeen = false
        var content: CardContent
        
//        // MARK: - Bonus time
//        var bonusTimeLimit: TimeInterval = 6
//        var lastFaceUpDate: Date?
//        var pastFaceUpTime: TimeInterval = 0
//
//        private var faceUpTime: TimeInterval {
//            if let lastFaceUpDate = self.lastFaceUpDate {
//                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
//            } else {
//                return pastFaceUpTime
//            }
//        }
//
//        var bonusTimeRemaining: TimeInterval {
//            max(0, bonusTimeLimit - faceUpTime)
//        }
//
//        var bonusRemaining: Double {
//            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining / bonusTimeLimit : 0
//        }
//
//        var hasEarnedBonus: Bool {
//            isMatched && bonusTimeRemaining > 0
//        }
//
//        var isConsumingBonusTime: Bool {
//            isFaceUp && !isMatched && bonusTimeRemaining > 0
//        }
//
//        private mutating func startUsingBonusTime() {
//            if isConsumingBonusTime, lastFaceUpDate == nil {
//                lastFaceUpDate = Date()
//            }
//        }
//
//        private mutating func stopUsingBonusTime() {
//            pastFaceUpTime = faceUpTime
//            self.lastFaceUpDate = nil
//        }
    }
}

extension Array {
    var oneAndOnly: Element? {
        self.count == 1 ? first : nil
    }
}
