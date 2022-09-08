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
        
        /*let performerTheWeeknd = Artist(name: "The weeknd")
        self.musicTracks?.append(MusicTrack(title: "Can't feel my face", artist: performerTheWeeknd, filePath: musicCodebaseBundle.path(forResource: "the_weeknd-cant_feel_my_face", ofType: "mp3")!))
        self.musicTracks?.append(MusicTrack(title: "Secrets", artist: performerTheWeeknd, filePath: musicCodebaseBundle.path(forResource: "the_weeknd-secrets", ofType: "mp3")!))
        self.musicTracks?.append(MusicTrack(title: "Ordinary life", artist: performerTheWeeknd, filePath: musicCodebaseBundle.path(forResource: "the_weeknd-ordinary_life", ofType: "mp3")!))*/
        
        /*self.musicTracks?.append(MusicTrack(filePath: musicCodebaseBundle.path(forResource: "the_weeknd-cant_feel_my_face", ofType: "mp3")!))
        self.musicTracks?.append(MusicTrack(filePath: musicCodebaseBundle.path(forResource: "the_weeknd-secrets", ofType: "mp3")!))
        self.musicTracks?.append(MusicTrack(filePath: musicCodebaseBundle.path(forResource: "the_weeknd-ordinary_life", ofType: "mp3")!))*/
        
        self.loadAllMusicTracksFromBundle()
    }
    
    public func loadAllMusicTracksFromBundle() {
        var musicCodebaseBundle = Bundle(for: type(of: self))
        var paths = musicCodebaseBundle.paths(forResourcesOfType: "mp3", inDirectory: nil)
        for path in paths {
            self.musicTracks?.append(MusicTrack(fileName: URL(fileURLWithPath: path).lastPathComponent))
        }
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
