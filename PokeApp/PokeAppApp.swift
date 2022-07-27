//
//  PokeAppApp.swift
//  PokeApp
//
//  Created by Igor Łopatka on 20/07/2022.
//

import SwiftUI

@main
struct PokeAppApp: App {
    
    @StateObject private var viewModel = PokeAppViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
        }
    }
}
