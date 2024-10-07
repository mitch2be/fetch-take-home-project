//
//  ListView.swift
//  fetch-take-home-project
//
//  Created by Blake Mitchell on 10/4/24.
//

import SwiftUI
import UIKit

struct ListView: View {
    @EnvironmentObject var viewModel: ListViewModel
    @State private  var viewDidLoad = false
    
    var body: some View {
        NavigationStack {
            List(viewModel.recipes, id: \.self) { recipe in
                ListRow(recipe: recipe)
                    .listRowSeparator(.hidden)
                    .navigationBarTitle(Text("Recipes"),
                                        displayMode: .inline)
            }
            .background(ColorConstants.app_background_color.toColor())
            .frame( maxWidth: .infinity)
            .edgesIgnoringSafeArea(.horizontal)
            .listStyle(PlainListStyle())
            .overlay(alignment: .top, content: {
                if viewModel.updateOverlay {
                    if viewModel.requestStatus.showOverlay() {
                        RefreshableOverlay(text: viewModel.requestStatus.overlayText(), viewModel: viewModel)
                    }
                }
            })
            .refreshable {
                viewModel.load()
            }.onAppear {
                if viewDidLoad == false {
                    viewDidLoad = true

                    viewModel.load()
                }
            }
        }
    }
}

struct RefreshableOverlay: View {
    var text: String
    var viewModel: ListViewModel
    
    var body: some View {
        List {
            OverlayView(title: text)
                .frame(maxWidth: .infinity, alignment: .center)
        }.refreshable {
            viewModel.load()
        }
    }
}
