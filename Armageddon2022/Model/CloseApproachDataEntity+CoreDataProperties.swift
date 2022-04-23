//
//  CloseApproachDataEntity+CoreDataProperties.swift
//  Armageddon2022
//
//  Created by Даниил Багаутдинов on 23.04.2022.
//
//

import Foundation
import CoreData


extension CloseApproachDataEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CloseApproachDataEntity> {
        return NSFetchRequest<CloseApproachDataEntity>(entityName: "CloseApproachDataEntity")
    }

    @NSManaged public var closeApproachDate: String?
    @NSManaged public var closeApproachDateFull: String?
    @NSManaged public var epochDateCloseApproach: Int64
    @NSManaged public var orbitingBody: String?
    @NSManaged public var nearEarthObject: NearEarthObjectEntity?
    @NSManaged public var relativeVelocity: RelativeVelocityEntity?
    @NSManaged public var missDistance: MissDistanceEntity?

}

extension CloseApproachDataEntity : Identifiable {

}
