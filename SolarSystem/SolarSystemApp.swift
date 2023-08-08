//
//  SolarSystemApp.swift
//  SolarSystem
//
//  Created by Zijun Ye
//

import SwiftUI


@main
struct SolarSystemApp: App {
    var body: some Scene {
        WindowGroup {
            Planet()
        }.windowStyle(.volumetric)
        

    }
    init() {
        // Register all the custom components and systems that the app uses.
        RotationComponent.registerComponent()
        RotationSystem.registerSystem()
    }
}
