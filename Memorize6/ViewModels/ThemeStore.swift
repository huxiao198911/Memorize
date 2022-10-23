//
//  ThemeStore.swift
//  Memorize6
//
//  Created by Xiao Hu on 01/09/2022.
//

import SwiftUI

// MARK: - Theme struct
struct Theme: Identifiable, Codable, Hashable {
    var id: Int
    var name: String
    var emojis: String
    var color: RGBAColor
    var numbeOfPairedCards: Int
    
    init(id: Int, name: String, emojis: String, color: RGBAColor, numberOfPairedCards: Int) {
        self.id = id
        self.name = name
        self.emojis = emojis
        self.color = color
        self.numbeOfPairedCards = max(2, min(numberOfPairedCards, emojis.count))
    }
}

struct RGBAColor: Codable, Equatable, Hashable {
    let red: Double
    let green: Double
    let blue: Double
    let alpha: Double
}
//
extension Color {
    init(rgbaColor rgba: RGBAColor) {
        self.init(.sRGB, red: rgba.red, green: rgba.green, blue: rgba.blue, opacity: rgba.alpha)
    }
}

extension RGBAColor {
    init(color: Color) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        if let cgColor = color.cgColor {
            UIColor(cgColor: cgColor).getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        }
        self.init(red: Double(red), green: Double(green), blue: Double(blue), alpha: Double(alpha))
    }
    
    init(_ red: Double, _ green: Double, _ blue: Double, _ alpha: Double) {
        self.init(red: red/255, green: green/255 , blue: blue/255, alpha: alpha)
    }
}

// MARK: - ThemeStore class

class ThemeStore: ObservableObject {
    @Published var chosenThemeIndex = 0
    
    var name: String = "Preview"
    
    @Published var themes = [Theme]() {
        didSet {
//            storeInUserDefaults()
        }
    }
    
    private var userDefaultsKey: String {
        "ThemeStore:" + name
    }
    
    private func storeInUserDefaults() {
        UserDefaults.standard.set(try? JSONEncoder().encode(themes), forKey: userDefaultsKey)
    }
    
    private func restoreFromUserDefaults() {
        if let jsonData = UserDefaults.standard.data(forKey: userDefaultsKey),
           let decodedThemes = try? JSONDecoder().decode(Array<Theme>.self, from: jsonData) {
            themes = decodedThemes
        }
    }
    
    init(named name: String) {
        self.name = name
//        restoreFromUserDefaults()
        if themes.isEmpty {
            insertTheme(
                named: "Vehicles",
                emojis: "🚙🚗🚘🚕🚖🏎🚚🛻🚛🚐🚓🚔🚑🚒🚀✈️🛫🛬🛩🚁🛸🚲🏍🛶⛵️🚤🛥🛳⛴🚢🚂🚝🚅🚆🚊🚉🚇🛺🚜",
//                emojis: ["🚗","🚘","🚙","🚛","🚎","🏎","🚕","🚚","🚐","🚖","🚌","🚜","🚒","🛻"],
                of:  Color(rgbaColor: RGBAColor(255, 143, 20, 1)),
                with: 6
            )
            insertTheme(
                named: "Animals",
                emojis: "🐥🐣🐂🐄🐎🐖🐏🐑🦙🐐🐓🐁🐀🐒🦆🦅🦉🦇🐢🐍🦎🦖🦕🐅🐆🦓🦍🦧🦣🐘🦛🦏🐪🐫🦒🦘🦬🐃🦙🐐🦌🐕🐩🦮🐈🦤🦢🦩🕊🦝🦨🦡🦫🦦🦥🐿🦔",
//                emojis: ["🐱","🐈","🐈‍⬛","🐕‍🦺","🦮","🐁","🐇","🐰","🐮"],
                of: Color(rgbaColor: RGBAColor(86, 178, 62, 1)),
                with: 7
            )
            insertTheme(
                named: "Faces",
                emojis: "😀😃😄😁😆😅😂🤣🥲☺️😊😇🙂🙃😉😌😍🥰😘😗😙😚😋😛😝😜🤪🤨🧐🤓😎🥸🤩🥳😏😞😔😟😕🙁☹️😣😖😫😩🥺😢😭😤😠😡🤯😳🥶😥😓🤗🤔🤭🤫🤥😬🙄😯😧🥱😴🤮😷🤧🤒🤠",
//                emojis: ["🤣","😘","😊","😭","🥰","🤔","😆","😡","🤗","😎","😋","😞"],
                of: Color(rgbaColor: RGBAColor(248, 218, 9, 1)),
                with: 8
            )
            insertTheme(
                named: "Sports",
                emojis: "🏈⚾️🏀⚽️🎾🏐🥏🏓⛳️🥅🥌🏂⛷🎳",
//                emojis: ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S"],
                of: Color(rgbaColor: RGBAColor(229, 108, 204, 1)),
                with: 10
            )
            insertTheme(
                named: "Flora",
                emojis: "🌲🌴🌿☘️🍀🍁🍄🌾💐🌷🌹🥀🌺🌸🌼🌻",
//                emojis: ["🍒","🍓","🍇","🍎","🍉","🍑","🍊","🍋","🍍","🍌","🥑","🍏","🍈","🍐"],
                of: Color(rgbaColor: RGBAColor(37, 75, 240, 1)),
                with: 9
            )
            insertTheme(
                named: "Music",
                emojis: "🎼🎤🎹🪘🥁🎺🪗🪕🎻",
//                emojis: ["🍔","🍖","🥓","🥩","🍗","🐟","🍤","🐙","🦞","🦑","🍱","🍣","🦀"],
                of: Color(rgbaColor: RGBAColor(29, 108, 204, 0.5)),
                with: 5
            )
        } else {
            print("Successfully loaded themes from UserDefaults: \(themes)")
        }
    }
    
    // MARK: - Intents
    func theme(at index: Int) -> Theme {
        let safeIndex = min(max(index, 0), themes.count - 1)
        return themes[safeIndex]
    }
    
    // The @discardableResult attribute allows us to enable both cases without having to deal with annoying warnings or underscore replacements.
    @discardableResult
    func removeTheme(at index: Int) -> Int {
        if themes.count > 1,
           themes.indices.contains(index) {
            themes.remove(at: index)
        }
        return index % themes.count
    }
    
    func insertTheme(named name: String, emojis: String? = nil, of color: Color = Color(rgbaColor: RGBAColor(243, 63, 63, 1)), at index: Int = 0, with numberOfPairedCards: Int? = 5) {
        let unique = (themes.max(by: { $0.id < $1.id })?.id ?? 0) + 1
        let theme = Theme(id: unique, name: name, emojis: emojis ?? "", color: RGBAColor(color: color), numberOfPairedCards: numberOfPairedCards ?? 5)
        let safeIndex = min(max(index, 0), themes.count)
        themes.insert(theme, at: safeIndex)
    }
}

