//
//  TheListView.swift
//  Enemy Losses
//
//  Created by Ihor Makhnyk for MacPaw
//


import SwiftUI

//MARK: - Main View
struct TheListView: View {
    @ObservedObject var fetch = FetchPersonnel()
    @ObservedObject var fetch1 = FetchEquipment()
    @State var filteredNotes = [
        DataPersonnel(date: "2022-02-23", id: 0, personnel: 0, personnel_a: "about", POW: 0),
        DataPersonnel(date: "2022-02-24", id: 1, personnel: 800, personnel_a: "about", POW: 0)
    ]
    var equipID: Int = 0
    
    @ObservedObject var localise_class: Localise
    @State var showAlert = false
    @State var searchQuery = ""
    @State var menu = true
    @Binding var isLoading: Bool
    
    @Environment(\.colorScheme) var colorScheme
    
    @available(iOS 15.0, *)
    var body: some View {
        NavigationView {
            TabView {
                VStack {
                    HStack{
                        Label("total".localized(lang: localise_class.general_lan), systemImage: "person.3").frame(width: 250, alignment: .leading).padding(.leading, -20)
                        Text("**≈  \(fetch.dataPersonnel.first?.personnel ?? 0)**").frame(width: 80).padding(.leading, 10).onChange(of: fetch.dataPersonnel.first?.personnel) { _ in
                            filterNotes()
                            isLoading = false
                        }
                        
                    }.frame(height: 30, alignment: .topLeading).padding(.top, 4)
                        .onAppear() {filteredNotes = fetch.dataPersonnel}
                    List {
                            ForEach(filteredNotes) { dataPersonnel in NavigationLink( destination: DayDetail(page_id: dataPersonnel.id, lan: localise_class)) {
                                Models(dataPersonnel: dataPersonnel, dateFormat: datePicker(data: dataPersonnel.date!, lan: localise_class.general_lan), lan: localise_class)
                                }
                            }
                    }.cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color(UIColor.systemBackground), lineWidth: 3)
                                .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 4)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .shadow(color: .black.opacity(0.3), radius: -5, x: 0, y: 4)
                                .clipShape(
                                    RoundedRectangle(cornerRadius: 20)
                                )
                        )
                        .onAppear(){
                            filteredNotes = fetch.dataPersonnel
                            if fetch.dataPersonnel.endIndex < 3 && !isLoading {showAlert = true
                            }
                        }
                    
                    
                    Text("🇺🇦🇺🇦🇺🇦 Слава ЗСУ! 🇺🇦🇺🇦🇺🇦").font(.caption).padding(.bottom, 3).cornerRadius(50)
                }.onAppear() { filteredNotes = fetch.dataPersonnel
                    menu = true
                }
                .tabItem(){
                    Label("general".localized(lang: localise_class.general_lan), systemImage: "doc.richtext.fill.he")
                }.tint(colorScheme == .dark ? .yellow : .blue)
                SettingsUI(localise_class: localise_class, menu: $menu).tabItem(){
                    Label("settings".localized(lang: localise_class.general_lan), systemImage: "gear")
                }
            }.navigationTitle("app_name".localized(lang: localise_class.general_lan))
                .toolbar(menu ? .visible : .hidden, in: .navigationBar)
                
        }.accentColor(colorScheme == .dark ? .yellow : .blue)
        .onAppear() {filteredNotes = fetch.dataPersonnel}
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Cannot load the data"),
                    message: Text("Please make sure that you " +
                                  "are connected to the network" + " and restart the app."),
                    primaryButton: .default(
                        Text("Try Again"),
                        action: filterNotes
                    ),
                    secondaryButton: .destructive(
                        Text("Quit"),
                        action: quit
                    )
                )
            }
    }
    //MARK: - Filter funcition for search bar
    func quit() { exit(0) }
    
    func filterNotes() {
        
        if searchQuery.isEmpty {
            filteredNotes = fetch.dataPersonnel
        }
        else {
            if searchQuery.count == 1 {
                filteredNotes = fetch.dataPersonnel.filter {
                    $0.id!.description.localizedCaseInsensitiveContains(searchQuery) && $0.id! < 11
                }
            } else {
                filteredNotes = fetch.dataPersonnel.filter {
                    $0.id!.description.localizedCaseInsensitiveContains(searchQuery)
                }
            }
        }
    }
}
