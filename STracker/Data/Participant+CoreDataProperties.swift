//
//  Participant+CoreDataProperties.swift
//  STracker
//
//  Created by Isaac Allport on 01/10/2021.
//
//

import Foundation
import CoreData


extension Participant {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Participant> {
        return NSFetchRequest<Participant>(entityName: "Participant")
    }

    @NSManaged public var name: String?
    @NSManaged public var score: String?
    @NSManaged public var points: Int16
    @NSManaged public var house: String?
    @NSManaged public var race: Race?

}

extension Participant : Identifiable {

}
