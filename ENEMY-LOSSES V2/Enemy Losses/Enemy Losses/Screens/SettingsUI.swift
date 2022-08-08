//
//  SettingsUI.swift
//  Enemy Losses
//
//  Created by Ihor Makhnyk on MacPaw
//

import SwiftUI

//MARK: - Settings page
struct SettingsUI: View {
    //Languages defined by localised strings
    @ObservedObject var localise_class: Localise
    @Binding var menu: Bool
    @State var _selected_language = "uk"
        var _languages = ["en", "uk"]
    //View
    var body: some View {
        NavigationView(){
            List {
                //My personal note
                Section {
                    Label("**\("note".localized(lang: _selected_language))**", systemImage: "signature")
                    Text("author_notes".localized(lang: _selected_language)).font(.callout).frame(minHeight: 180, idealHeight: 200, maxHeight: 350, alignment: .center).padding(.top, -20)
                }.onAppear() {
                    set_lan()
                }
                
                //Language switch (in development)
                HStack(alignment: .center) {
                    Label("language".localized(lang: _selected_language) + "   ", systemImage: "globe").frame(width: 150, alignment: .leading)
                    Picker("Choose the language.", selection: $_selected_language) {
                        ForEach(_languages, id: \.self) {
                            Text($0.localized(lang: _selected_language))
                        }
                    }.onChange(of: _selected_language) { _ in set_lan()}
                    .pickerStyle(.segmented)
                    .frame(alignment: .center)
                }.frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
            }//.toolbar(.hidden, in: .navigationBar)
            .navigationTitle("settings".localized(lang: _selected_language))
        }.onAppear() { menu = false }
    }
    func set_lan(){
        localise_class.general_lan = _selected_language
    }
}

//MARK: - Preview Manager
struct SettingsUI_Previews: PreviewProvider {
    static var previews: some View {
        SettingsUI(localise_class: Localise(), menu: .constant(true))
    }
}
