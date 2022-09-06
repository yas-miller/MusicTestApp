//
//  Performer.swift
//  MusicCodebase
//
//  Created by Андрей Ясюкевич on 6.09.22.
//

import Foundation

public class Performer: Codable, Identifiable
{
    public var id: UUID = UUID()
    public var name: String!
    
    public init(name: String) {
        self.name = name
    }
}
