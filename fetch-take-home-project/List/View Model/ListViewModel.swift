//
//  ListViewModel.swift
//  fetch-take-home-project
//
//  Created by Blake Mitchell on 10/4/24.
//

import Foundation
import DataTypes

final class ListViewModel: ObservableObject {
        
    @Published var recipes: [Recipe] = []
    
    @Published var updateOverlay: Bool = true
    
    @Published var requestStatus: RequestStatus = .loading {
        didSet {
            updateOverlay = true
        }
    }
        
    private var loader = RecipeFeedLoader()
    
    func load() {
        loader.load { [weak self] result in
            guard let self = self else { return }
            
            Task { @MainActor in
                switch result {
                case .success(let recipeList):
                    self.recipes = recipeList
                    self.requestStatus = recipeList.isEmpty ? .successNoResults : .success
                case .failure(_):
                    self.requestStatus = .error
                }
            }
        }
    }
}
