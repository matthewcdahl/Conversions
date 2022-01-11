//
//  ConversionsApp.swift
//  Conversions
//
//  Created by Matt Dahl on 1/9/22.
//

import SwiftUI

@main
struct ConversionsApp: App {
    var body: some Scene {
        WindowGroup {
            LaunchTabView()
                .environmentObject(FunctionModel())
        }
    }
}
