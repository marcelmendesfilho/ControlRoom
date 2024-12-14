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
                                        Button {
                                        } label: {
                                            Label("Restore", systemImage: "arrow.counterclockwise")
                                        }

                                        Button {
                                        } label: {
                                            Label("Rename", systemImage: "pencil")
                                        }

                                        Text(snapshot.name)

                                        Button {
                                        } label: {
                                            Label("Delete", systemImage: "trash")
                                        }
                                        
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
