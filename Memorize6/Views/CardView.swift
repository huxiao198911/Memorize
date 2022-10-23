//
//  CardView.swift
//  Memorize6
//
//  Created by Xiao Hu on 31/08/2022.
//

import SwiftUI

struct CardView: View {
    var card: MemorizeModel<String>.Card
    
    @State private var animatedBonusRemaining: Double = 0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
//                Group {
//                    if card.isConsumingBonusTime {
//                        Pie(startAngle: Angle(degrees: 0 - 90), endAngle: Angle(degrees: (1 - animatedBonusRemaining) * 360 - 90))
//                            .onAppear {
//                                animatedBonusRemaining = card.bonusRemaining
//                                withAnimation(.linear(duration: card.bonusTimeRemaining)) {
//                                    animatedBonusRemaining = 0
//                                }
//                            }
//                    } else {
//                        Pie(startAngle: Angle(degrees: 0 - 90), endAngle: Angle(degrees: (1 - card.bonusRemaining) * 360 - 90))
//                    }
//                }
//                .padding(6)
//                .opacity(0.5)
                
                ZStack{
                    let shape = RoundedRectangle(cornerRadius: 20)
                    if card.isFaceUp {
                        shape.fill().foregroundColor(.white)
                        shape.strokeBorder(lineWidth: 3)
                        Text(card.content).font(.largeTitle)
                    } else if card.isMatched {
                        shape.opacity(0)
                    } else {
                        shape.fill()
                        
                    }
                }
            }
//            .cardify(isFaceUp: card.isFaceUp)
        }
    }
    
    private func scale(thatFits size: CGSize) -> CGFloat {
        min(size.width, size.height) / (CardConstants.fontSize / CardConstants.fontScale)
    }
    
    private func font(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * CardConstants.fontScale)
    }
    
    private struct CardConstants {
        static let cornerRadius: CGFloat = 10
        static let defaultLineWidth: CGFloat = 2
        static let effectLineWidth: CGFloat = 3
        static let effectOpacity: CGFloat = 0.2
        static let fontScale: CGFloat = 0.5
        static let fontSize: CGFloat = 32
    }
}

//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView()
//    }
//}
