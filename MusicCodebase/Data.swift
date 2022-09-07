//
//  Data.swift
//  MusicCodebase
//
//  Created by Андрей Ясюкевич on 6.09.22.
//

import Foundation
import EasyStash
import AVFoundation

public class Data: ObservableObject, Codable
{
    @Published public var musicTracks: [MusicTrack]?
    
    public init()
    {
        
    }
    
    public func loadGenericData()
    {
        var musicCodebaseBundle = Bundle(for: type(of: self))
        
        self.musicTracks = [MusicTrack]()
        
        let performerTheWeeknd = Performer(name: "The weeknd")
        self.musicTracks?.append(MusicTrack(name: "Can't feel my face", performer: performerTheWeeknd, filePath: musicCodebaseBundle.path(forResource: "the_weeknd-cant_feel_my_face", ofType: "mp3")!))
        self.musicTracks?.append(MusicTrack(name: "Secrets", performer: performerTheWeeknd, filePath: musicCodebaseBundle.path(forResource: "the_weeknd-secrets", ofType: "mp3")!))
        self.musicTracks?.append(MusicTrack(name: "Ordinary life", performer: performerTheWeeknd, filePath: musicCodebaseBundle.path(forResource: "the_weeknd-ordinary_life", ofType: "mp3")!))
        self.musicTracks?.append(MusicTrack(name: "Can't feel my face", performer: performerTheWeeknd, filePath: musicCodebaseBundle.path(forResource: "the_weeknd-cant_feel_my_face", ofType: "mp3")!))
        self.musicTracks?.append(MusicTrack(name: "Secrets", performer: performerTheWeeknd, filePath: musicCodebaseBundle.path(forResource: "the_weeknd-secrets", ofType: "mp3")!))
        self.musicTracks?.append(MusicTrack(name: "Ordinary life", performer: performerTheWeeknd, filePath: musicCodebaseBundle.path(forResource: "the_weeknd-ordinary_life", ofType: "mp3")!))
        self.musicTracks?.append(MusicTrack(name: "Can't feel my face", performer: performerTheWeeknd, filePath: musicCodebaseBundle.path(forResource: "the_weeknd-cant_feel_my_face", ofType: "mp3")!))
        self.musicTracks?.append(MusicTrack(name: "Secrets", performer: performerTheWeeknd, filePath: musicCodebaseBundle.path(forResource: "the_weeknd-secrets", ofType: "mp3")!))
        self.musicTracks?.append(MusicTrack(name: "Ordinary life", performer: performerTheWeeknd, filePath: musicCodebaseBundle.path(forResource: "the_weeknd-ordinary_life", ofType: "mp3")!))
        self.musicTracks?.append(MusicTrack(name: "Can't feel my face", performer: performerTheWeeknd, filePath: musicCodebaseBundle.path(forResource: "the_weeknd-cant_feel_my_face", ofType: "mp3")!))
        self.musicTracks?.append(MusicTrack(name: "Secrets", performer: performerTheWeeknd, filePath: musicCodebaseBundle.path(forResource: "the_weeknd-secrets", ofType: "mp3")!))
        self.musicTracks?.append(MusicTrack(name: "Ordinary life", performer: performerTheWeeknd, filePath: musicCodebaseBundle.path(forResource: "the_weeknd-ordinary_life", ofType: "mp3")!))
    }
    
    public func loadDataLocally() throws
    {
        var storage = try EasyStash.Storage(options: {
            var o = Options();
            o.folder = "Data";
            return o;
        }())
        let loadedData = try storage.load(forKey: String(describing: self), as: Data.self)
        self.musicTracks = loadedData.musicTracks
    }
    
    public func saveDataLocally() throws
    {
        var storage = try EasyStash.Storage(options: {
            var o = Options();
            o.folder = "Data";
            return o;
        }())
        try storage.save(object: self, forKey: String(describing: self))
    }
}
