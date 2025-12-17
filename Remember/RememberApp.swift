//
//  RememberApp.swift
//  Remember
//
//  Created by HOCC on 12/13/25.
//

import SwiftUI

@main
struct RememberApp: App {
    var body: some Scene {
        WindowGroup {
            if #available(iOS 26.0, *) {
                ContentView()
            } else {
                ContentViewiOS18()
            }

        }
    }
}
