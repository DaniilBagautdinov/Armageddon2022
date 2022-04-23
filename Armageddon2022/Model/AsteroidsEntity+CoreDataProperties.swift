//
//  AsteroidsEntity+CoreDataProperties.swift
//  Armageddon2022
//
//  Created by Даниил Багаутдинов on 23.04.2022.
//
//

import Foundation
import CoreData


extension AsteroidsEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AsteroidsEntity> {
        return NSFetchRequest<AsteroidsEntity>(entityName: "AsteroidsEntity")
    }

    @NSManaged public var date: String?
    @NSManaged public var nearEarthObjects: NSSet?

}

// MARK: Generated accessors for nearEarthObjects
extension AsteroidsEntity {

    @objc(addNearEarthObjectsObject:)
    @NSManaged public func addToNearEarthObjects(_ value: NearEarthObjectEntity)

    @objc(removeNearEarthObjectsObject:)
    @NSManaged public func removeFromNearEarthObjects(_ value: NearEarthObjectEntity)

    @objc(addNearEarthObjects:)
    @NSManaged public func addToNearEarthObjects(_ values: NSSet)

    @objc(removeNearEarthObjects:)
    @NSManaged public func removeFromNearEarthObjects(_ values: NSSet)

}

extension AsteroidsEntity : Identifiable {

}
