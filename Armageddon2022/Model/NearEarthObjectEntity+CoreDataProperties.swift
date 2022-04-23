//
//  NearEarthObjectEntity+CoreDataProperties.swift
//  Armageddon2022
//
//  Created by Даниил Багаутдинов on 23.04.2022.
//
//

import Foundation
import CoreData


extension NearEarthObjectEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NearEarthObjectEntity> {
        return NSFetchRequest<NearEarthObjectEntity>(entityName: "NearEarthObjectEntity")
    }

    @NSManaged public var id: String?
    @NSManaged public var neoReferenceId: String?
    @NSManaged public var name: String?
    @NSManaged public var isPotentiallyHazardousAsteroid: Bool
    @NSManaged public var isSentryObject: Bool
    @NSManaged public var asteroids: AsteroidsEntity?
    @NSManaged public var estimatedDiameter: EstimatedDiameterEntity?
    @NSManaged public var closeApproachData: NSSet?

}

// MARK: Generated accessors for closeApproachData
extension NearEarthObjectEntity {

    @objc(addCloseApproachDataObject:)
    @NSManaged public func addToCloseApproachData(_ value: CloseApproachDataEntity)

    @objc(removeCloseApproachDataObject:)
    @NSManaged public func removeFromCloseApproachData(_ value: CloseApproachDataEntity)

    @objc(addCloseApproachData:)
    @NSManaged public func addToCloseApproachData(_ values: NSSet)

    @objc(removeCloseApproachData:)
    @NSManaged public func removeFromCloseApproachData(_ values: NSSet)

}

extension NearEarthObjectEntity : Identifiable {

}
