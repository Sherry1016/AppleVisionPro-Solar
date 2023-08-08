//
//  SunEntity+Configuration.swift
//  SolarSystem
//
//  Created by Zijun Ye
//

import SwiftUI

extension SunEntity {
    /// Configuration information for Sun entities.
    struct Configuration {
        

        var scale: Float = 0.6
        var rotation: simd_quatf = .init(angle: 0, axis: [0, 1, 0])
        var speed: Float = 0
        var position: SIMD3<Float> = .zero
        

        static var orbitEarthDefault: Configuration = .init(
            scale: 0.4,
            speed: 0.1)

    }
}
