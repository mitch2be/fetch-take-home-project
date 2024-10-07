//
//  AppLauncher.swift
//  fetch-take-home-project
//
//  Created by Blake Mitchell on 10/4/24.
//

import SwiftUI

@main
struct AppLauncher {
    static func main() throws {
        if NSClassFromString("XCTestCase") == nil {
            fetch_take_home_projectApp.main()
        } else {
            TestApp.main()
        }
    }
}

struct fetch_take_home_projectApp: App {
    var body: some Scene {
        WindowGroup {
            ListView()
                .environmentObject(ListViewModel())
        }
    }
}

struct TestApp: App {

    var body: some Scene {
        WindowGroup { Text("Running Unit Tests") }
    }
}
