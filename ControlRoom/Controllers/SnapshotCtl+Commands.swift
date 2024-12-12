//
//  Command.swift
//  ControlRoom
//
//  Created by Marcel Mendes on 12/12/24.
//  Copyright © 2024 Paul Hudson. All rights reserved.
//

import Foundation

extension SnapshotCtl {
    
    struct Command: CommandLineCommand {
        let arguments: [String]
        let environmentOverrides: [String: String]?
        
        private init(_ command: String, arguments: [String], environmentOverrides: [String: String]? = nil) {
            self.arguments = [command] + arguments
            self.environmentOverrides = environmentOverrides
        }
        
        static func createSnapshotsFolder() -> Command {
            Command("mkdir", arguments: ["./snapshots"])
        }
        
        static func getTimestamp(deviceId: String) -> Command {
            Command("GetFileInfo", arguments: ["-d", "./\(deviceId)"])
        }
        
        static func getSnapshots(deviceId: String) -> Command {
            Command("printf", arguments: ["\"%s\n\"", "./*/*/"])
        }
        
        static func getSnapshotsSizes(deviceId: String) -> Command {
            Command("du", arguments: ["-hd", "./\(deviceId)"])
        }
        
        static func createSnapshotFolder(deviceId: String, snapshotName: String) -> Command {
            Command("mkdir", arguments:["\(deviceId)/\(snapshotName)"])
        }
        
        static func createSnapshot(deviceId: String, snapshotName: String) -> Command {
            Command("cp", arguments: ["../\(deviceId)", "\(deviceId)/\(snapshotName)/"])
        }

        static func deleteSnapshot(deviceId: String, snapshotName: String) -> Command {
            Command("rm", arguments: ["-rF", "./\(deviceId)/\(snapshotName)/"])
        }
        
        static func deleteAllSnapshots(deviceId: String) -> Command {
            Command("rm", arguments: ["-rF", "./\(deviceId)"])
        }
        
        static func deleteSimulator(deviceId: String) -> Command {
            Command("rm", arguments: ["-rF", "../\(deviceId)"])
        }

        static func restoreSnapshot(deviceId: String, snapshotName: String) -> Command {
            Command("cp", arguments: ["\(deviceId)/\(snapshotName)", "../"])
        }

    }
    
}
