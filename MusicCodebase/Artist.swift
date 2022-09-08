//
//  Performer.swift
//  MusicCodebase
//
//  Created by Андрей Ясюкевич on 6.09.22.
//

import Foundation

public class Artist: Codable, Identifiable
{
    public var id: UUID = UUID()
    public var name: String!
    
    private init(name: String) {
        self.name = name
    }
    
    private static var KnownArtists: [Artist] = [Artist]()
    public static func GetArtistByName(name: String) -> Artist {
        if let knownArtist = KnownArtists.first(where: {$0.name == name}) {
            return knownArtist
        }
        else {
            let newArtist = Artist(name: name)
            KnownArtists.append(newArtist)
            return newArtist
        }
    }
}
