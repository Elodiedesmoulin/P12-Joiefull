//
//  ContentView.swift
//  Joiefull
//
//  Created by Elo on 22/05/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        if UIDevice.isPad {
            HomeWithDetailView()
        } else {
            HomeView()
        }
    }
}

#Preview {
    ContentView()
}
