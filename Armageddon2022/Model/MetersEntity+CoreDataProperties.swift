//
//  MetersEntity+CoreDataProperties.swift
//  Armageddon2022
//
//  Created by Даниил Багаутдинов on 23.04.2022.
//
//

import Foundation
import CoreData


extension MetersEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MetersEntity> {
        return NSFetchRequest<MetersEntity>(entityName: "MetersEntity")
    }

    @NSManaged public var estimatedDiameterMin: Double
    @NSManaged public var estimatedDiameterMax: Double
    @NSManaged public var estimatedDiameter: EstimatedDiameterEntity?

}

extension MetersEntity : Identifiable {

}
