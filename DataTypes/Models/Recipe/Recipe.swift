//
//  Recipe.swift
//  DataTypes
//
//  Created by Blake Mitchell on 10/4/24.
//

import Foundation

public struct Recipe: Codable, Hashable {
    enum CodingKeys: String, CodingKey {
        case cuisine, name
        
        case id = "uuid"
        case photoURLLarge = "photo_url_large"
        case photoURLSmall = "photo_url_small"
        case sourceURL = "source_url"
        case youTubeURL = "youtube_url"
    }
        
    public var id: String
    public var name: String
    public var cuisine: String
    public var photoURLLarge: String?
    public var photoURLSmall: String?
    public var sourceURL: String
    public var youTubeURL: String
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = (try? values.decodeIfPresent(String.self, forKey: .id)) ?? ""
        self.name = (try? values.decodeIfPresent(String.self, forKey: .name)) ?? ""
        self.cuisine = (try? values.decodeIfPresent(String.self, forKey: .cuisine)) ?? ""
        self.photoURLLarge = (try? values.decodeIfPresent(String.self, forKey: .photoURLLarge)) ?? nil
        self.photoURLSmall = (try? values.decodeIfPresent(String.self, forKey: .photoURLSmall)) ?? nil
        self.sourceURL = (try? values.decodeIfPresent(String.self, forKey: .sourceURL)) ?? ""
        self.youTubeURL = (try? values.decodeIfPresent(String.self, forKey: .youTubeURL)) ?? ""
    }
}
