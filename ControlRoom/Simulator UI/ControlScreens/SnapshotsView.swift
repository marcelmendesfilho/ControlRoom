//
//  SnapshotsView.swift
//  ControlRoom
//
//  Created by Marcel Mendes on 14/12/24.
//  Copyright © 2024 Paul Hudson. All rights reserved.
//


import SwiftUI

struct SnapshotsView: View {
	let simulator: Simulator
	@ObservedObject var controller: SimulatorsController

	var body: some View {
		ScrollView {
            if controller.snapshots.count > 0 {
                Form {
					Section {
						LabeledContent("Snapshots:") {
							VStack(alignment: .leading, spacing: 5) {
								ForEach(controller.snapshots) { snapshot in
									HStack {
										Button("Restore", action: placeholder)
										Button("Rename", action: placeholder)
										Text(snapshot.name)
										Button("Erase", action: placeholder)
                                        Spacer()
									}
								}
							}
						}
					}
                }
                .padding()
            } else {
                VStack(spacing: 10) {
                    Spacer()
                    Image(systemName: simulator.deviceFamily.snapshotUnavailableIcon)
                    Text("No snapshots yet")
                }
                .font(.title)
			}
		}
        .tabItem {
            Text("Snapshots")
        }

	}
	
	func placeholder() {}

}
