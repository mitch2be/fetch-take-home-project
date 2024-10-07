//
//  RecipeLoader.swift
//  fetch-take-home-project
//
//  Created by Blake Mitchell on 10/4/24.
//

import Foundation
import DataTypes
import HTTPRequest

protocol RecipeLoader {
    
    typealias Result = Swift.Result<[Recipe], Error>
        
    func load(completion: @escaping (Result) -> Void)
}

final class RecipeFeedLoader: RecipeLoader {
    
    private var client: HTTPClient
    private var request: URLRequest
    
    init(client: HTTPClient = HTTPRequestClient(), request: URLRequest = RequestBuilder(urlString: URLConstants.GET_recipes).build()) {
        self.client = client
        self.request = request
    }
    
    func load(completion: @escaping (RecipeLoader.Result) -> Void) {
        client.request(request) { [weak self]  result in
            guard let self = self else { return }
            
            switch result {
            case .success(let json, _):
                completion(.success(self.decodeResults(json: json)))
                return
            case .failure(let error, _):
                completion(.failure(error))
                return
            }
        }
    }
}

extension RecipeFeedLoader {
    func decodeResults(json: Any) -> [Recipe] {
        guard let obj = list(from: json) else { return [] }
        
        do {
            let json = try JSONSerialization.data(withJSONObject: obj)
            return try JSONDecoder().decode([Recipe].self, from: json)
        } catch {
            return []
        }
    }
    
    func list(from json: Any) -> Any? {
        guard let list = json as? [String: Any] else  { return nil }
        
        return list["recipes"]
    }
}
