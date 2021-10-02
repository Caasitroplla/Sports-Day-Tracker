//
//  Race+CoreDataProperties.swift
//  STracker
//
//  Created by Isaac Allport on 01/10/2021.
//
//

import Foundation
import CoreData


extension Race {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Race> {
        return NSFetchRequest<Race>(entityName: "Race")
    }

    @NSManaged public var gender: Bool
    @NSManaged public var relay: String?
    @NSManaged public var title: String?
    @NSManaged public var trackOrField: String?
    @NSManaged public var participants: NSSet?

}

// MARK: Generated accessors for participants
extension Race {

    @objc(addParticipantsObject:)
    @NSManaged public func addToParticipants(_ value: Participant)

    @objc(removeParticipantsObject:)
    @NSManaged public func removeFromParticipants(_ value: Participant)

    @objc(addParticipants:)
    @NSManaged public func addToParticipants(_ values: NSSet)

    @objc(removeParticipants:)
    @NSManaged public func removeFromParticipants(_ values: NSSet)

}

extension Race : Identifiable {

}
