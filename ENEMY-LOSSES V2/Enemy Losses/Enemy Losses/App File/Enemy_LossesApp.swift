//
//  Enemy_LossesApp.swift
//  Enemy Losses
//
//  Created by Ihor Makhnyk on 05.08.2022.
//

import SwiftUI

@main
struct Enemy_LossesApp: App {
    @ObservedObject var lan = Localise()
    var body: some Scene {
        WindowGroup {
            TheListView(localise_class: lan, isLoading: FetchPersonnel().$isLoading)
        }
    }
}

