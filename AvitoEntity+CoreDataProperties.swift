//
//  AvitoEntity+CoreDataProperties.swift
//  Avito_Chagellenge
//
//  Created by Asf on 26.10.2022.
//
//

import Foundation
import CoreData


extension AvitoEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AvitoEntity> {
        return NSFetchRequest<AvitoEntity>(entityName: "AvitoEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var phoneNumber: String?
    @NSManaged public var skills: [String]?

}

extension AvitoEntity : Identifiable {

}
