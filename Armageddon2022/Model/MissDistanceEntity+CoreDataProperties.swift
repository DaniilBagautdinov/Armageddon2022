//
//  MissDistanceEntity+CoreDataProperties.swift
//  Armageddon2022
//
//  Created by Даниил Багаутдинов on 23.04.2022.
//
//

import Foundation
import CoreData


extension MissDistanceEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MissDistanceEntity> {
        return NSFetchRequest<MissDistanceEntity>(entityName: "MissDistanceEntity")
    }

    @NSManaged public var lunar: String?
    @NSManaged public var kilometers: String?
    @NSManaged public var closeApproachData: CloseApproachDataEntity?

}

extension MissDistanceEntity : Identifiable {

}
