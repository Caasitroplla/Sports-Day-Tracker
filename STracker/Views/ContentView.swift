//
//  ContentView.swift
//  STracker
//
//  Created by Isaac Allport on 01/10/2021.
//

import SwiftUI
import CoreData
import Foundation

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(sortDescriptors: [],animation: .default)
	var Races: FetchedResults<Race>
	
	var body: some View {
		NavigationView {
			List {
				ForEach(Races) { Race in
					NavigationLink(destination: ParticipantView(index: Races.firstIndex(of: Race)!)) {
						if #available(iOS 15.0, *) {
							RaceView(Race: Race)
								.swipeActions {
									Button("delete") {
										deleteRace(offsets: [Races.firstIndex(of: Race)!])
									}
									.tint(.red)
									Button("edit") {
										UpdateRaceAlertView(Race)
									}
									.tint(.yellow)
								}
						} else {
							// Fallback on earlier versions
						}
					}
				}
				.onDelete(perform: deleteRace)
			}
			.navigationTitle("Races")
			.navigationBarItems(trailing: Button("add race") {
				NewRaceAlertView()
			})
			.navigationBarItems(leading: Button(action: InfoAlert) {
				Label("", systemImage: "info.circle")
			})
		}
	}
	
	private func saveContext() {
		do {
			try viewContext.save()
			// tries to save the modifications to the environment object to the database
		} catch {
			let error = error as NSError
			print("cant save context about to die")
			fatalError("Unresolved Error: \(error)")
			// if it doesn't work keel over and die
		}
	}
	
	func InfoAlert() {
		// TODO: make info alert
	}
	
	func NewRaceAlertView(){
		// the alert for a new race
		let alert = UIAlertController(title: "New Race", message: "Enter the new race name in the text field below.", preferredStyle: .alert)
		
		alert.addTextField { workingRaceName in
			workingRaceName.placeholder = "New Race Name"
		}
		
		let createAction = UIAlertAction(title: "Create Race", style: .default) { (_) in
			withAnimation {
				// Create new Race
				let newRace = Race(context: viewContext)
				
				// Give it its attributes
				newRace.title = alert.textFields![0].text!

				// Save and reload
				saveContext()
			}
		}
		
		let cancelAction = UIAlertAction(title: "Cancel", style: .destructive) { (_) in
			//canceled so do nothing
		}
		
		alert.addAction(createAction)
		alert.addAction(cancelAction)
		
		UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: {
			// do anything here
		})
	}
	
	func UpdateRaceAlertView(_ Race: FetchedResults<Race>.Element){
		// the alert view for a update on a race
		let alert = UIAlertController(title: "Update Race", message: "Enter the new/updated race name in the text field below.", preferredStyle: .alert)
		
		// show race title
		alert.addTextField { updateRaceName in
			updateRaceName.placeholder = Race.title
		}
		
		// show gender
		alert.addTextField { updateGender in
			if Race.gender {
				updateGender.placeholder = "Male"
			} else {
				updateGender.placeholder = "Female"
			}
		}
		
		// add track or field placeholder
		alert.addTextField { updateTrackorField in
			updateTrackorField.placeholder = Race.trackOrField ?? "track or field"
		}
		
		// add relay race text field
		alert.addTextField { updateRelay in
			updateRelay.placeholder = Race.relay ?? "type of relay A, B or C"
		}
		
		// update race alert view
		let updateAction = UIAlertAction(title: "Update Race", style: .default) { (_) in
			withAnimation {
				// modify the race
				Race.title = alert.textFields![0].text!
				
				if alert.textFields![1].text! != "" {
					if alert.textFields![1].text!.lowercased() == "male" {
						Race.gender = true
					} else {
						Race.gender = false
					}
				}
				
				if alert.textFields![2].text! != "" {
					if alert.textFields![2].text!.lowercased() == "track" {
						Race.trackOrField = "track"
					} else if alert.textFields![2].text!.lowercased() == "field" {
						Race.trackOrField = "field"
					}
				}
				
				if alert.textFields![3].text! != "" {
					if alert.textFields![3].text!.lowercased() == "a" {
						Race.relay = "A"
					} else if alert.textFields![3].text!.lowercased() == "b" {
						Race.relay = "B"
					} else if alert.textFields![3].text!.lowercased() == "c" {
						Race.relay = "C"
					}
				}
				
				// save and reload changes
				saveContext()
			}
		}
		
		let cancelAction = UIAlertAction(title: "Cancel", style: .destructive) { (_) in
		}
		
		alert.addAction(updateAction)
		alert.addAction(cancelAction)
		
		UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: {
			// this is ran on completion
		})
	}
	
	private func deleteRace(offsets: IndexSet) {
		withAnimation {
			offsets.map { Races[$0] }.forEach(viewContext.delete)
			// maps the offsets of locations of deletes and goes through each one and deletes it
			saveContext()
		}
	}
	
	
}
