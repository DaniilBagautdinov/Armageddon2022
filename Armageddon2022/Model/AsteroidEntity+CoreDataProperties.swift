//
//  AsteroidEntity+CoreDataProperties.swift
//  Armageddon2022
//
//  Created by Даниил Багаутдинов on 24.04.2022.
//
//

import Foundation
import CoreData


extension AsteroidEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AsteroidEntity> {
        return NSFetchRequest<AsteroidEntity>(entityName: "AsteroidEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: String?
    @NSManaged public var diameterMax: Double
    @NSManaged public var diameterMin: Double
    @NSManaged public var missDistance: Double
    @NSManaged public var isPotentiallyHazardousAsteroid: Bool
    @NSManaged public var date: String?

}

extension AsteroidEntity : Identifiable {

}
