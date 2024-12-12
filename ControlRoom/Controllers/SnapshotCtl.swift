//
//  SnapshotCtl.swift
//  ControlRoom
//
//  Created by Marcel Mendes on 12/12/24.
//  Copyright © 2024 Paul Hudson. All rights reserved.
//

import Foundation

enum SnapshotCtl: CommandLineCommandExecuter {
    typealias Error = CommandLineError
    
    static var launchPath = ""
    static var devicesPath = ""
    
    static func configureDevicesPath(dataPath: String?) {
        guard let dataPath else {
            print("Missing dataPath. Snapshots won't be created.")
            return
        }
        
        var folders: [String] = []
        
        dataPath.split(separator: "/").forEach {
            folders.append("\($0)")
        }
        
        if let devicesIndex: Int = folders.firstIndex(of: "Devices") {
            devicesPath = "/" + folders.prefix(devicesIndex + 1).joined(separator: "/")
        }
    }
    
    static func getTimestamp(deviceId: String) {
        execute(.getTimestamp(deviceId: deviceId))
    }
    
    static func getSnapshots(deviceId: String) {
        execute(.getSnapshots(deviceId: deviceId))
    }
    
    static func getSnapshotsSizes(deviceId: String) {
        execute(.getSnapshotsSizes(deviceId: deviceId))
    }
    
    static func createSnapshot(deviceId: String, snapshotName: String) {
        execute(.createSnapshotTree(deviceId: deviceId, snapshotName: snapshotName)) { _ in
   
            execute(.createSnapshot(deviceId: deviceId, snapshotName: snapshotName)) { result in
                switch result {
                case .success:
                    break
                case .failure(let error):
                    print("Error creating snapshot: \(error)")
                }
            }
            
        }
    }
    
    static func deleteSnapshot(deviceId: String, snapshotName: String) {
        execute(.deleteSnapshot(deviceId: deviceId, snapshotName: snapshotName))
    }
    
    static func deleteAllSnapshots(deviceId: String) {
        execute(.deleteAllSnapshots(deviceId: deviceId))
    }
    
    static func restoreSnapshot(deviceId: String, snapshotName: String) {
        execute(.deleteSimulator(deviceId: deviceId)) { _ in
            execute(.restoreSnapshot(deviceId: deviceId, snapshotName: snapshotName))
        }
    }
        
}
