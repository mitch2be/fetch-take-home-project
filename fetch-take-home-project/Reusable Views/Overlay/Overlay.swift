//
//  Overlay.swift
//  fetch-take-home-project
//
//  Created by Blake Mitchell on 10/4/24.
//

import SwiftUI

struct OverlayView: View {
    
    var title: String
    
    var body: some View {
        ColorConstants.app_background_color.toColor().ignoresSafeArea()
            .overlay {
                Text(title)
            }
    }
}
