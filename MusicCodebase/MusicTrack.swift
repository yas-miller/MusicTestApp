//
//  MusicTrack.swift
//  MusicCodebase
//
//  Created by Андрей Ясюкевич on 6.09.22.
//

import Foundation

public class MusicTrack: ObservableObject, Identifiable, Codable
{
    @Published public var uuid: UUID
    @Published public var name: String
    @Published public var performer: Performer
    @Published public var filePath: String

    public init(name: String, performer: Performer, filePath: String) {
        self.uuid = UUID()
        self.name = name
        self.performer = performer
        self.filePath = filePath
    }
}
