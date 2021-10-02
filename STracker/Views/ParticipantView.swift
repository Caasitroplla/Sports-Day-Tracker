//
//  ParticipantView.swift
//  STracker
//
//  Created by Isaac Allport on 01/10/2021.
//

import SwiftUI

struct ParticipantView: View {
	
	@Environment(\.managedObjectContext) private var viewContext

	@FetchRequest(sortDescriptors: [])
	var Races: FetchedResults<Race>
	
	var index: Int
	
    var body: some View {
		List {
			if Races[index].participants != nil {
				ForEach(Array(Races[index].participants as! Set<Participant>), id: \.self) { participant in
					HStack {
						Text(participant.name ?? "unamed")
						Spacer()
						Text(participant.house ?? "homeless")
						Spacer()
						Text(participant.score ?? "DNF")
						Spacer()
						Text(String(participant.points))
					}
					.onTapGesture(perform: {
						EditParticipantAlertView(participant)
					})
				}
			}
		}
		.navigationBarTitle(Races[index].title ?? "Untitled")
		.toolbar {
			Button(action: {
				NewParticipantAlertView(Races[index])
			}) {
				Image(systemName: "person.badge.plus")
			}
		}
    }
	
	private func saveContext() {
		do {
			try viewContext.save()
			// tries to save the modifications to the environment object to the database
		} catch {
			print("why the hell did this trigger")
			let error = error as NSError
			fatalError("Unresolved Error: \(error)")
			// if it doesn't work keel over and die
		}
	}
	
	func NewParticipantAlertView(_ Race: FetchedResults<Race>.Element){
		// the alert for a new race
		let alert = UIAlertController(title: "New Participant", message: "Enter new participants name below", preferredStyle: .alert)
		
		alert.addTextField { newParticpantName in
			newParticpantName.placeholder = "New Participant Name"
		}
		
		alert.addTextField { newHouse in
			newHouse.placeholder = "New house (optional)"
			
		}
		
		let createAction = UIAlertAction(title: "Create Race", style: .default) { (_) in
			withAnimation {
				// Create new Race
				let newParticipant = Participant(context: viewContext)
				newParticipant.name = alert.textFields![0].text!
				newParticipant.points = 0
				
				if alert.textFields![1].text! != "" {
					if alert.textFields![1].text!.lowercased() == "fereby" {
						// TODO: make sure fereby is spelt correctly
						newParticipant.house = "fereby"
					} else if alert.textFields![1].text!.lowercased() == "hix" {
						newParticipant.house = "hix"
					} else if alert.textFields![1].text!.lowercased() == "townsend" {
						newParticipant.house = "townsend"
					}
				}
				
				// Add to race
				Race.addToParticipants(newParticipant)
				
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
	
	func EditParticipantAlertView(_ participant: Participant){
		// the alert for a new race
		let alert = UIAlertController(title: "Edit Participant", message: "Edit participants attributes.", preferredStyle: .alert)
		
		alert.addTextField { newParticpantName in
			newParticpantName.placeholder = participant.name
		}
		
		alert.addTextField { newHouse in
			newHouse.placeholder = participant.house
		}
		
		alert.addTextField { newScore in
			newScore.placeholder = participant.score ?? "DNF"
		}
		
		alert.addTextField { newPoints in
			newPoints.placeholder = String(participant.points)
			
		}
		
		let createAction = UIAlertAction(title: "Create Race", style: .default) { (_) in
			withAnimation {
				// Create new Race
				if alert.textFields![0].text! != "" {
					participant.name = alert.textFields![0].text!
				}
				
				if alert.textFields![1].text! != "" {
					if alert.textFields![1].text!.lowercased() == "fereby" {
						// TODO: make sure fereby is spelt correctly
						participant.house = "fereby"
					} else if alert.textFields![1].text!.lowercased() == "hix" {
						participant.house = "hix"
					} else if alert.textFields![1].text!.lowercased() == "townsend" {
						participant.house = "townsend"
					}
				}
				
				if alert.textFields![2].text! != "" {
					participant.score = alert.textFields![2].text!.lowercased()
				}
				
				if alert.textFields![3].text! != "" {
					participant.points = Int16(alert.textFields![3].text!)!
				}
				
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
	
}

//struct ParticipantView_Previews: PreviewProvider {
//    static var previews: some View {
//        ParticipantView()
//    }
//}
