//
//  ListView+views.swift
//  fetch-take-home-project
//
//  Created by Blake Mitchell on 10/4/24.
//

import SwiftUI
import DataTypes
import Kingfisher

extension ListView {
    
    struct ListRow: View {
        var recipe: Recipe
                        
        var body: some View {
            VStack {
                ZStack(alignment: .leading) {
                        HStack {
                            if let photoSmallURLString = recipe.photoURLSmall {
                                RecipeImage(urlString: photoSmallURLString)
                            } else {
                                RecipeNoImage()
                            }
                            
                            Spacer()
                                .frame(width: 16)

                            VStack(alignment: .leading) {
                                RecipeName(recipe: recipe)
                                RecipeInformation(recipe: recipe)
                            }
                            .background(ColorConstants.app_background_color.toColor())
                    }.frame(maxWidth: .none)
                        .background(ColorConstants.app_background_color.toColor())
                }.frame(maxWidth: .infinity,
                        maxHeight: .infinity,
                        alignment: .leading)
                .background(ColorConstants.app_background_color.toColor())
            }
        }
    }
}

struct RecipeImage: View {
    var urlString: String!
    var failureImage = KFCrossPlatformImage(systemName: "photo")

    var body: some View {
        KFImage.url(URL(string: urlString)!)
            .placeholder {
                ProgressView()
            }
            .cacheMemoryOnly(false)
            .resizable()
            .onFailureImage(
                failureImage!
            )
            .scaledToFit()
            .frame(width: 110, height: 110)
            .clipShape(Rectangle())
            .cornerRadius(8)
    }
}

struct RecipeNoImage: View {
    var body: some View {
        Image(systemName: "photo")
            .resizable()
            .scaledToFit()
            .frame(width: 140, height: 140)
            .clipShape(Rectangle())
            .cornerRadius(8)
    }
}

struct RecipeName: View {
    var recipe: Recipe!
    
    var body: some View {
        Text(recipe.name)
            .font(.system(size: 18))
            .bold()
        Spacer()
            .frame(height: 8)
    }
}

struct RecipeInformation: View {
    var recipe: Recipe!
    
    var body: some View {
        Text(recipe.cuisine + " cuisine")
            .font(.system(size: 12))
    }
}
