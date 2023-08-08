//
//  Sun.swift
//  SolarSystem
//
//  Created by Zijun Ye
//

import SwiftUI
import RealityKit
import RealityKitContent

/// The model of the Sun.
struct Sun: View {
    var sunConfiguration: SunEntity.Configuration = .init()
    var planetConfiguration: [PlanetEntity.Configuration] = []

    /// The Sun entity that the view creates and stores for later updates.
    @State private var sunEntity: SunEntity?

    var body: some View {
        RealityView { content in
            // Create an Sun entity with tilt, rotation, and so on.
            let sunEntity = await SunEntity(
                configuration: sunConfiguration,
                planetConfiguration: planetConfiguration
            )
            content.add(sunEntity)

            // Store for later updates.
            self.sunEntity = sunEntity

        } update: { content in
            // Reconfigure everything when any configuration changes.
            sunEntity?.update(
                configuration: sunConfiguration,
                planetConfiguration: planetConfiguration
            )
        }
    }
}

#Preview {
    Sun(
        sunConfiguration: SunEntity.Configuration.orbitEarthDefault,
        planetConfiguration: [
            PlanetEntity.Configuration(
                name: "Earth1",
                isVisible: true,
                inclination: .degrees(30),
                speedRatio: 10,
                scale: 0.5,
                altitude: 0.9,
                traceWidth: 400,
                isTraceVisible: false)
        ]
    )
}
