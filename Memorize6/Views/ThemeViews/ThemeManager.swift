//
//  ThemeManager.swift
//  Memorize6
//
//  Created by Xiao Hu on 01/09/2022.
//

import SwiftUI

struct ThemeManager: View {
    @EnvironmentObject var store: ThemeStore
    @EnvironmentObject var game: MemorizeViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @State private var games = [Theme: MemorizeViewModel]()
    @State private var editMode: EditMode = .inactive
    @State private var themeToEdit: Theme?
    
    var body: some View {
        NavigationView {
            List {
                ForEach(store.themes.filter { $0.emojis.count > 1 }) { theme in
                    NavigationLink(destination: getDestination(for: theme)) {
                        themeRow(for: theme)
                        }
                        .gesture(editMode == .active ? tapToOpenThemeEditor(for: theme) : nil)
                    }
                .onDelete { indexSet in
                    store.themes.remove(atOffsets: indexSet)
                }
                .onMove { indexSet, newOffset in
                    store.themes.move(fromOffsets: indexSet, toOffset: newOffset)
                }
            }
        .listStyle(.inset)
            .navigationTitle("Memorize")
            //            .navigationBarTitleDisplayMode(.inline)
            .sheet(item: $themeToEdit) {
                removeNewThemeOnDismissIfInvalid()
            } content: { theme in
                ThemeEditor(theme: $store.themes[store.chosenThemeIndex])
            }
            .toolbar {
                ToolbarItem (placement: .navigationBarLeading) { addThemeButton }
                ToolbarItem { EditButton() }
                ToolbarItem(placement: .navigationBarLeading) {
                    if presentationMode.wrappedValue.isPresented,
                       UIDevice.current.userInterfaceIdiom != .pad {
                        Button("Close") {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
            }
            .environment(\.editMode, $editMode)
        }
        .onChange(of: store.themes) { newThemes in
        updateGames(to: newThemes)
        }
    }

private func themeRow(for theme: Theme) -> some View {
    VStack(alignment: .leading) {
        Text(theme.name)
            .foregroundColor(Color(rgbaColor: theme.color))
            .font(.system(size: 25))
            .bold()
        HStack {
            if theme.numbeOfPairedCards == theme.emojis.count {
                Text("All of \(theme.emojis)")
            } else {
                Text("\(String(theme.numbeOfPairedCards)) pairs from \(theme.emojis)")
            }
        }
        .lineLimit(1)
    }
}

private func getDestination(for theme: Theme) -> some View {
    if games[theme] == nil {
        let newGame = MemorizeViewModel(theme: theme)
        games.updateValue(newGame, forKey: theme)
        return MemorizeView(game: newGame)
    }
    return MemorizeView(game: games[theme]!)
}
    
 private var addThemeButton: some View {
//        AnimatedActionButton(title: "New", systemImage: "plus") {
//            themeToEdit = store.theme(at: store.chosenThemeIndex)
//            store.insertTheme(named: "New", at: store.chosenThemeIndex)
//        }
     Button {
         store.insertTheme(named: "new")
         themeToEdit = store.themes.first
     } label: {
         Image(systemName: "plus")
             .foregroundColor(.blue)
     }
    }
    
    private func tapToOpenThemeEditor(for theme: Theme) -> some Gesture {
        TapGesture().onEnded {
            themeToEdit = store.themes[store.chosenThemeIndex]
        }
    }
    
    private func removeNewThemeOnDismissIfInvalid() {
        if let newButInvalidTheme = store.themes.first {
            if newButInvalidTheme.emojis.count < 2 {
                store.removeTheme(at: 0)
            }
        }
    }
    
    private func updateGames(to newThemes: [Theme]) {
        store.themes
            .filter { $0.emojis.count >= 2 }
            .forEach { theme in
                if !newThemes.contains(theme) {
                    store.themes.remove(at: store.chosenThemeIndex)
                }
            }
    }
}
    

//
struct ThemeManager_Previews: PreviewProvider {
    static var previews: some View {
        ThemeManager().previewDevice("iPhone 13 mini")
            .environmentObject(ThemeStore(named: "default"))
            .preferredColorScheme(.light)
    }
}
