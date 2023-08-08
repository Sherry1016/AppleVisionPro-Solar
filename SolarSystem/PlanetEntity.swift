//
//  PlanetEntity.swift
//  SolarSystem
//
//  Created by Zijun Ye
//

import RealityKit
import SwiftUI
import RealityKitContent

/// A planet entity.
class PlanetEntity: Entity {
    
    // MARK: - Sub-entities

    private let planet: Entity
    private let box = Entity()
    private let orbit = Entity()

    // MARK: - Initializers

    @MainActor required init() {
        planet = Entity()
        super.init()
    }

    init(_ configuration: Configuration) async {
        do { // Load assets.
            planet = try await Entity(named: configuration.name, in: realityKitContentBundle)
        } catch {
            fatalError("Failed to load a model asset.")
        }

        super.init()

        // An entity whose orientation controls the inclination of the orbit.
        name = configuration.name
        isEnabled = configuration.isVisible

        // The entity that creates the planet's orbit using a rotation component.
        orbit.components.set(RotationComponent(speed: 0))
        orbit.orientation = .init(angle: Float(configuration.initialRotation.radians), axis: [0, 1, 0])
        self.addChild(orbit)

        // A container for the planet that can be scaled and
        // positioned without interfering with the trace.
        orbit.addChild(box)

        // The planet model that draws an optional trace.
        box.addChild(planet)
    }
    
    func update(
        configuration: Configuration,
        speed: Float,
        traceAnchor: Entity
    ) {
        isEnabled = configuration.isVisible

        if var rotation: RotationComponent = orbit.components[RotationComponent.self] {
            rotation.speed = configuration.speedRatio * speed
            orbit.components[RotationComponent.self] = rotation
        }

        box.scale = SIMD3(repeating: configuration.scale)
        box.position = [0, 0, configuration.altitude]
    }
}

