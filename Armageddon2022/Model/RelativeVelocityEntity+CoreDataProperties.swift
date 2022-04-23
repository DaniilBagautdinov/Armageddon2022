//
//  RelativeVelocityEntity+CoreDataProperties.swift
//  Armageddon2022
//
//  Created by Даниил Багаутдинов on 23.04.2022.
//
//

import Foundation
import CoreData


extension RelativeVelocityEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RelativeVelocityEntity> {
        return NSFetchRequest<RelativeVelocityEntity>(entityName: "RelativeVelocityEntity")
    }

    @NSManaged public var kilometersPerSecond: String?
    @NSManaged public var kilometersPerHour: String?
    @NSManaged public var milesPerHour: String?
    @NSManaged public var closeApproachData: CloseApproachDataEntity?

}

extension RelativeVelocityEntity : Identifiable {

}
