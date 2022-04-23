//
//  EstimatedDiameterEntity+CoreDataProperties.swift
//  Armageddon2022
//
//  Created by Даниил Багаутдинов on 23.04.2022.
//
//

import Foundation
import CoreData


extension EstimatedDiameterEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EstimatedDiameterEntity> {
        return NSFetchRequest<EstimatedDiameterEntity>(entityName: "EstimatedDiameterEntity")
    }

    @NSManaged public var nearEarthObject: NearEarthObjectEntity?
    @NSManaged public var meters: MetersEntity?

}

extension EstimatedDiameterEntity : Identifiable {

}
