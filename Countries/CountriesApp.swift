//
//  CountriesApp.swift
//  Countries
//
//  Created by MAC on 30/07/2025.
//

import SwiftUI

@main
struct CountriesApp: App {
    @StateObject var localizationManager = LocalizationManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .id(localizationManager.id) 
                .environmentObject(localizationManager)
                .environment(\.layoutDirection, localizationManager.layoutDirection)
                       
            //TestView()
        }
    }
}
