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
}
