//
//  Persistence.swift
//  STracker
//
//  Created by Isaac Allport on 01/10/2021.
//

import CoreData

struct PersistenceController {
	static let shared = PersistenceController()
	
	let container: NSPersistentContainer
	
	init() {
		container = NSPersistentContainer(name: "Races")
		
		container.loadPersistentStores { (storeDescription, error) in
			if let error = error as NSError? {
				fatalError("Unresolved error: \(error)")
			}
		}
	}
}
