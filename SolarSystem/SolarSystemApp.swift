//
//  SolarSystemApp.swift
//  SolarSystem
//
//  Created by Zheng Li on 7/29/23.
//

import SwiftUI

@main
struct SolarSystemApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.windowStyle(.volumetric)

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
    }
}
