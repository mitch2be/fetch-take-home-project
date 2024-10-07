//
//  MockURLSessionConfig.swift
//  fetch-take-home-projectTests
//
//  Created by Blake Mitchell on 10/4/24.
//

import Foundation
import Mocker

class MockURLSessionConfig {

    lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        return URLSession(configuration: configuration)
    }()
}
