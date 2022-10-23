//
//  ThemeEditor.swift
//  Memorize6
//
//  Created by Xiao Hu on 01/09/2022.
//

import SwiftUI

struct ThemeEditor: View {
    @Binding var theme: Theme
    @Environment(\.presentationMode) private var presentationMode
    
    @State private var candidateEmojis: String
    
    var body: some View {
        NavigationView {
            Form {
                nameSection
                addColorSection
                addNumberOfPairedCardsSection
                addEmojisSection
                removeEmojisSection
            }
            .navigationTitle("Edit \(theme.name)")
            .frame(minWidth: 300, minHeight: 350)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    cancelButton
                }
                ToolbarItem {
                    doneButton
                }
            }
        }
    }
    
    private var doneButton: some View {
        Button("Done") {
            if presentationMode.wrappedValue.isPresented && candidateEmojis.count >= 2 {
                saveAllEdits()
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
    
    private func saveAllEdits() {
        theme.name = name
        theme.emojis = candidateEmojis
        theme.numbeOfPairedCards = min(numberOfPairs, candidateEmojis.count)
        theme.color = RGBAColor(color: chosenColor)
    }
    
    private var cancelButton: some View {
        Button("Cancel") {
            if presentationMode.wrappedValue.isPresented {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
    
    init(theme: Binding<Theme>) {
        self._theme = theme
        self._name = State(initialValue: theme.wrappedValue.name)
        self._candidateEmojis = State(initialValue: theme.wrappedValue.emojis)
        self._numberOfPairs = State(initialValue: theme.wrappedValue.numbeOfPairedCards)
        self._chosenColor = State(initialValue: Color(rgbaColor: theme.wrappedValue.color))
    }
    
    @State private var name: String
    
    var nameSection: some View {
        Section(header: Text("Name")) {
            TextField("Name", text: $name)
        }
    }
    
    @State var chosenColor: Color = .red
    
    var addColorSection: some View {
        Section(header: Text("Add Color")) {
            ColorPicker("Set the theme color", selection: $chosenColor)
                .foregroundColor(chosenColor)
        }
    }
    
    
    @State var numberOfPairs: Int
    
    var addNumberOfPairedCardsSection: some View {
        Section(header: Text("Card count")) {
            Stepper("\(numberOfPairs) Pairs",
                    value: $numberOfPairs,
                    in: candidateEmojis.count < 2 ? 2...2 : 2...candidateEmojis.count)
            .onChange(of: candidateEmojis) { _ in
                numberOfPairs = max(2, min(numberOfPairs, candidateEmojis.count))
            }
        }
    }
    
    @State private var emojisToAdd = ""
    
    var addEmojisSection: some View {
        Section(header: Text("Add Emojis")) {
            TextField("Emojis", text: $emojisToAdd)
                .onChange(of: emojisToAdd) { emoji in
                    addToCandidateEmojis(emoji)
                }
        }
    }
    
    private func addToCandidateEmojis(_ emojis: String) {
        withAnimation {
            candidateEmojis = (emojis + candidateEmojis)
                .filter { $0.isEmoji }
                .removingDuplicateCharacters
        }
    }
    
    func addEmojis(_ emojis: String) {
        withAnimation {
            theme.emojis = (emojis + theme.emojis)
                .filter { $0.isEmoji }
                .removingDuplicateCharacters
        }
    }
    
    var removeEmojisSection: some View {
        Section(header: Text("Remove Emoji")) {
            let emojis = theme.emojis.removingDuplicateCharacters.map { String($0) }
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 40))]) {
                ForEach(emojis, id: \.self) { emoji in
                    Text(emoji)
                        .onTapGesture {
                            withAnimation {
                                if theme.emojis.count > 2 {
                                    theme.emojis.removeAll(where: { String($0) == emoji })
                                }
                            }
                        }
                }
            }
            .font(.system(size: 40))
        }
    }
    
}

//struct ThemeEditor_Previews: PreviewProvider {
//    static var previews: some View {
//        ThemeEditor(theme: .constant(ThemeStore().theme(at: 4)))
//            .previewLayout(.fixed(width: 300, height: 350))
//    }
//}
