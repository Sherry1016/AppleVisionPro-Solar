//
//  PlanetEntity+Configuration.swift
//  SolarSystem
//
//  Created by Zijun Ye
//

import SwiftUI

extension PlanetEntity {
    /// Configuration information for planet entities.
    struct Configuration {
        var name: String
        var isVisible: Bool = true
        var inclination: Angle = .zero
        var speedRatio: Float = 1
        var scale: Float = 1
        var altitude: Float = 0
        var traceWidth: Float = 400
        var isTraceVisible: Bool = false
        var initialRotation: Angle = .zero
        
    }
}
