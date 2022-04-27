//
//  CloseApproachDataEntity+CoreDataProperties.swift
//  Armageddon2022
//
//  Created by Даниил Багаутдинов on 27.04.2022.
//
//

import Foundation
import CoreData


extension CloseApproachDataEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CloseApproachDataEntity> {
        return NSFetchRequest<CloseApproachDataEntity>(entityName: "CloseApproachDataEntity")
    }

    @NSManaged public var asteroidId: String?
    @NSManaged public var closeApprouchDate: String?
    @NSManaged public var closeApprouchDateFull: String?
    @NSManaged public var orbitingBody: String?
    @NSManaged public var kilometersPerSecond: Double
    @NSManaged public var missDistanceKilometers: Double
    @NSManaged public var missDistanceLunar: Double

}

extension CloseApproachDataEntity : Identifiable {

}
