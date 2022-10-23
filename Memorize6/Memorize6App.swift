//
//  Memorize6App.swift
//  Memorize6
//
//  Created by Xiao Hu on 31/08/2022.
//

import SwiftUI

@main
struct Memorize6App: App {
    @StateObject var themeStore = ThemeStore(named: "default")
//    let game = MemorizeViewModel(theme: )
    
    var body: some Scene {
        WindowGroup {
            ThemeChooser()
                .environmentObject(themeStore)
        }
    }
}
