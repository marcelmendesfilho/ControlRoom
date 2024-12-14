//
//  Snapshot.swift
//  ControlRoom
//
//  Created by Marcel Mendes on 12/12/24.
//  Copyright © 2024 Paul Hudson. All rights reserved.
//
import Foundation

struct Snapshot: Equatable, Hashable, Identifiable {
    let id: UUID
    let name: String
    let creationDate: Date?
    let size: Int?
    
    static func == (lhs: Snapshot, rhs: Snapshot) -> Bool {
        lhs.name == rhs.name
    }
    
    init?(deviceId: String, name: String) {
        self.id = UUID()
        self.name = name
        self.creationDate = nil
        self.size = nil
    }
}
