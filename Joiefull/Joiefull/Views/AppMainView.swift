//
//  AppMainView.swift
//  Joiefull
//
//  Created by Elo on 10/06/2025.
//

import SwiftUI

struct AppMainView: View {
    @EnvironmentObject var viewModel: ArticleListViewModel
    @State private var selectedArticle: Article? = nil
    @State private var showAlert = false
    
    
    var body: some View {
        Group {
            if UIDevice.current.userInterfaceIdiom == .pad {
                if selectedArticle != nil {
                    iPadSplitView(selectedArticle: $selectedArticle)
                } else {
                    HomeiPadView(selectedArticle: $selectedArticle)
                }
            } else {
                HomeView()
            }
        }
        .environmentObject(viewModel)
        .onAppear { Task { await viewModel.loadArticles() } }
        
        .onReceive(viewModel.$errorMessage) { msg in
            if msg != nil { showAlert = true }
        }
        .alert("Erreur", isPresented: $showAlert, actions: {
            Button("OK") { viewModel.errorMessage = nil }
        }, message: {
            Text(viewModel.errorMessage ?? "Une erreur inconnue est survenue.")
        })
    }
}

