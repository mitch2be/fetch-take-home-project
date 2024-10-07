//
//  HTTPResult.swift
//  HTTPRequest
//
//  Created by Blake Mitchell on 10/4/24.
//

import Foundation

@frozen public enum RequestResult {
    case success(_ data: Any, _ statusCode: Int?)
    case failure(_ error: Error, _ statusCode: Int?)
}
