//
//  Asteroids.swift
//  Armageddon2022
//
//  Created by Даниил Багаутдинов on 23.04.2022.
//

import Foundation

struct Asteroids: Codable {
    let nearEarthObjects: [String: [NearEarthObject]]?
}

struct NearEarthObject: Codable {
    let id, neoReferenceId, name: String?
    let estimatedDiameter: EstimatedDiameter?
    let isPotentiallyHazardousAsteroid: Bool?
    let closeApproachData: [CloseApproachData]?
    let isSentryObject: Bool?
}

struct EstimatedDiameter: Codable {
    let meters: Meters?
}

struct Meters: Codable {
    let estimatedDiameterMin, estimatedDiameterMax: Double?
}

struct CloseApproachData: Codable {
    let closeApproachDate, closeApproachDateFull: String?
    let epochDateCloseApproach: Int?
    let relativeVelocity: RelativeVelocity?
    let missDistance: MissDistance?
    let orbitingBody: String?
}

struct RelativeVelocity: Codable {
    let kilometersPerSecond, kilometersPerHour, milesPerHour: String?
}

struct MissDistance: Codable {
    let lunar, kilometers: String?
}
