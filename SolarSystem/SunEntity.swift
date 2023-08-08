//
//  SunEntity.swift
//  SolarSystem
//
//  Created by Zijun Ye
//

import RealityKit
import SwiftUI
import RealityKitContent

/// An entity that represents the Sun and all its moving parts.
class SunEntity: Entity {

    // MARK: - Sub-entities

    /// The model that draws the Sun's surface features.
    private let sun: Entity

    /// An entity that rotates 23.5° to create axial tilt.
    private let equatorialPlane = Entity()

    /// An entity that provides a configurable rotation,
    /// separate from the day/night cycle.
    private let rotator = Entity()

    /// A container for planets.
    private let planets = Entity()


    // MARK: - Initializers

    /// Creates a new blank sun entity.
    @MainActor required init() {
        sun = Entity()
        super.init()
    }

    /// Creates a new sun entity with the specified configuration.
    ///
    /// - Parameters:
    ///   - configuration: Information about how to configure the Sun.
    ///   - planetConfiguration: An array of configuration structures, one
    ///     for each planet.
    ///
    init(
        configuration: Configuration,
        planetConfiguration: [PlanetEntity.Configuration]
        
    ) async {
        do { // Load assets.
            sun = try await Entity(
                named: "SunScene",
                in: realityKitContentBundle
            )
           
            
            for configuration in planetConfiguration {
                await planets.addChild(PlanetEntity(configuration))
            }
        } catch {
            fatalError("Failed to load a model asset.")
        }

        super.init()

        // Attach to the Sun to a set of entities that enable axial
        // tilt and a configured amount of rotation around the axis.
        self.addChild(equatorialPlane)
        equatorialPlane.addChild(rotator)
        rotator.addChild(sun)

        // The inclination of planet orbits is measured relative
        // to the Sun's equator, so attach the planet container to the
        // equatorial plane entity.
        equatorialPlane.addChild(planets)

        // Configure everything for the first time.
        update(
            configuration: configuration,
            planetConfiguration: planetConfiguration

        )
    }

    // MARK: - Updates

    /// Updates all the entity's configurable elements.
    ///
    /// - Parameters:
    ///   - configuration: Information about how to configure the Sun.
    ///   - planetConfiguration: An array of configuration structures, one
    ///     for each planet.
    
    func update(
        configuration: Configuration,
        planetConfiguration: [PlanetEntity.Configuration]
        
    ) {
        // Update the artificial planets.
        for planet in planets.children {
            guard let planetConfiguration = planetConfiguration.first(where: { $0.name == planet.name }) else { continue }
            (planet as? PlanetEntity)?.update(
                configuration: planetConfiguration,
                speed: configuration.speed,
                traceAnchor: sun)
        }
    }
}

