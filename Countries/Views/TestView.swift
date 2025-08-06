//
//  TestView.swift
//  Countries
//
//  Created by MAC on 05/08/2025.
//

import SwiftUI

struct TestView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text(LocalizedStringKey("Countries"))
            Text("Search")
            Text("Done")
            Text("Loading...")
        }
        .navigationTitle("Countries")
        .padding()
    }
}


