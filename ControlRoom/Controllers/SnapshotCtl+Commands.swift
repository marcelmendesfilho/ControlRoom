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
        static let snapshotsFolder: String = ".snapshots"

        var command: String?
        let arguments: [String]
        let environmentOverrides: [String: String]?
        
        private init(_ command: String, arguments: [String], environmentOverrides: [String: String]? = nil) {
            self.command = command
            self.arguments = arguments
            self.environmentOverrides = environmentOverrides
        }
        
        static func getTimestamp(deviceId: String) -> Command {
            Command("/usr/bin/GetFileInfo", arguments: ["-d", "\(devicesPath)/\(snapshotsFolder)/\(deviceId)"])
        }
        
        static func getSnapshots(deviceId: String) -> Command {
            Command("/usr/bin/printf", arguments: ["\"%s\n\"", "\(devicesPath)/\(snapshotsFolder)/*/*/"])
        }
        
        static func getSnapshotsSizes(deviceId: String) -> Command {
            Command("/usr/bin/du", arguments: ["-hd", "\(devicesPath)/\(snapshotsFolder)/\(deviceId)"])
        }
        
        static func createSnapshotTree(deviceId: String, snapshotName: String) -> Command {
            Command("/bin/mkdir", arguments:["-p", "\(devicesPath)/\(snapshotsFolder)/\(deviceId)/\(snapshotName)"])
        }
        
        static func createSnapshot(deviceId: String, snapshotName: String) -> Command {
            Command("/usr/bin/rsync", arguments: ["-a", "\(devicesPath)/\(deviceId)", "\(devicesPath)/\(snapshotsFolder)/\(deviceId)/\(snapshotName)/"])
        }

        static func deleteSnapshot(deviceId: String, snapshotName: String) -> Command {
            Command("/bin/rm", arguments: ["-rF", "\(devicesPath)/\(snapshotsFolder)/\(deviceId)/\(snapshotName)/"])
        }
        
        static func deleteAllSnapshots(deviceId: String) -> Command {
            Command("/bin/rm", arguments: ["-rF", "\(devicesPath)/\(snapshotsFolder)/\(deviceId)"])
        }
        
        static func deleteSimulator(deviceId: String) -> Command {
            Command("/bin/rm", arguments: ["-rF", "\(devicesPath)/\(deviceId)"])
        }

        static func restoreSnapshot(deviceId: String, snapshotName: String) -> Command {
            Command("/bin/cp", arguments: ["\(devicesPath)/\(snapshotsFolder)/\(deviceId)/\(snapshotName)", "\(devicesPath)/"])
        }

    }
    
}
