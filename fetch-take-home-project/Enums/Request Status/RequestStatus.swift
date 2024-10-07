//
//  RequestStatus.swift
//  fetch-take-home-project
//
//  Created by Blake Mitchell on 10/4/24.
//

import Foundation

enum RequestStatus {
    case loading
    case success
    case successNoResults
    case error
}

extension RequestStatus {

    func showOverlay() -> Bool {
        switch self {
        case .success:
            return false
        default:
            return true
        }
    }
    
    func overlayText() -> String {
        switch self {
        case .loading:
            return "Loading..."
        case .success:
            return ""
        case .successNoResults:
            return "No results."
        case .error:
            return "Network error. Please pull to refresh."
        }
    }
}
