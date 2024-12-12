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
    
    static var launchPath = "./"
    
    static func createSnapshotsFolder() {
        execute(.createSnapshotsFolder())
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
        execute(.createSnapshotFolder(deviceId: deviceId, snapshotName: snapshotName)) { _ in
            execute(.createSnapshot(deviceId: deviceId, snapshotName: snapshotName))
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
