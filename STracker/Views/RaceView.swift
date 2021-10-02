//
//  RaceView.swift
//  STracker
//
//  Created by Isaac Allport on 01/10/2021.
//

import SwiftUI

struct RaceView: View {
	
	var Race: FetchedResults<Race>.Element
	
    var body: some View {
		HStack {
			
			// Race name
			Text(Race.title ?? "Untitled")
			
			Spacer()
			
			// Race gender
			if Race.gender == true {
				Image(systemName: "person")
					.foregroundColor(Color(.systemBlue))
			} else {
				Image(systemName: "person")
					.foregroundColor(Color.pink)
			}
			
			Spacer()
			
			// Race disiplin
			if Race.trackOrField == "track" {
				Image(systemName: "figure.walk")
			} else {
				Image(systemName: "figure.stand")
			}
			
			Spacer()
			
			// Race relay
			if Race.relay == "A" || Race.relay == "B" {
				Image(systemName: "person.3")
			} else {
				Image(systemName: "person")
			}
		}
    }
}

//struct RaceView_Previews: PreviewProvider {
//    static var previews: some View {
//        RaceView()
//    }
//}
