//
//  AsteroidEntity+CoreDataProperties.swift
//  Armageddon2022
//
//  Created by Даниил Багаутдинов on 27.04.2022.
//
//

import Foundation
import CoreData


extension AsteroidEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AsteroidEntity> {
        return NSFetchRequest<AsteroidEntity>(entityName: "AsteroidEntity")
    }

    @NSManaged public var date: String?
    @NSManaged public var diameterMax: Double
    @NSManaged public var diameterMin: Double
    @NSManaged public var id: String?
    @NSManaged public var isDestroy: Bool
    @NSManaged public var isPotentiallyHazardousAsteroid: Bool
    @NSManaged public var missDistanceKilometers: Double
    @NSManaged public var missDistanceLunar: Double
    @NSManaged public var name: String?

}

extension AsteroidEntity : Identifiable {

}
