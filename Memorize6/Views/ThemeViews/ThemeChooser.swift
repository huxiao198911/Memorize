//
//  ThemeChooser.swift
//  Memorize6
//
//  Created by Xiao Hu on 01/09/2022.
//

import SwiftUI

struct ThemeChooser: View {
    @EnvironmentObject var store: ThemeStore
    @EnvironmentObject var games: MemorizeViewModel
    
    @State private var managing = false
    @State private var themeToEdit: Theme?
    
    var body: some View {
            ThemeManager()
    }
    
//    var themeControlButton: some View {
//        Button {
//            store.chosenThemeIndex = (store.chosenThemeIndex + 1) % store.themes.count
//        } label: {
//            Text("Memorize")
//        }
//        .contextMenu { contextMenu }
//    }
    
//    @ViewBuilder
//    var contextMenu: some View {
//        AnimatedActionButton(title: "Edit", systemImage: "pencil") {
//            themeToEdit = store.theme(at: store.chosenThemeIndex)
//        }
//        AnimatedActionButton(title: "New", systemImage: "plus") {
//            themeToEdit = store.theme(at: store.chosenThemeIndex)
//            store.insertTheme(named: "New", emojis: "", at: store.chosenThemeIndex)
//        }
//        AnimatedActionButton(title: "Delete", systemImage: "minus.circle") {
//            store.chosenThemeIndex = store.removeTheme(at: store.chosenThemeIndex)
//        }
//        AnimatedActionButton(title: "Manager", systemImage: "slider.vertical.3") {
//            managing = true
//        }
//        goToMenu
//    }
//
//    var goToMenu: some View {
//        Menu {
//            ForEach(store.themes) {theme in
//                AnimatedActionButton(title: theme.name) {
//                    if let index = store.themes.firstIndex(where: { $0.id == theme.id }) {
//                        store.chosenThemeIndex = index
//                    }
//                }
//            }
//        } label: {
//            Label("Go To", systemImage: "text.insert")
//        }
//    }
}

//struct ScrollingEmojisView: View {
//    let emojis: String
//
//    var body: some View {
//        ScrollView(.horizontal) {
//            HStack {
//                ForEach(emojis.removingDuplicateCharacters.map { String($0) }, id: \.self) { emoji in
//                    Text(emoji)
//                    // NSItemProvider: the object that provide the data to somewhere else, when we dragging and dropping, we are provding the data provided in the (). provide the info asynchronously
//                        .onDrag {
//                            NSItemProvider(object: emoji as NSString)
//                        }
//                }
//            }
//        }
//    }
//}

struct ThemeChooser_Previews: PreviewProvider {
    static var previews: some View {
        ThemeChooser()
            .environmentObject(MemorizeViewModel(theme: ThemeStore(named: "default").theme(at: 5)))
            .environmentObject(ThemeStore(named: "default"))
    }
}
