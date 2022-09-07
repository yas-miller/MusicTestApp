//
//  MusicTrack.swift
//  MusicCodebase
//
//  Created by Андрей Ясюкевич on 6.09.22.
//

import Foundation
import AVFoundation
import UIKit

public class MusicTrack: ObservableObject, Identifiable, Codable
{
    @Published public var uuid: UUID
    @Published public var name: String
    @Published public var artist: Performer
    @Published public var filePathURL: String

    public init(name: String, performer: Performer, filePath: String) {
        self.uuid = UUID()
        self.name = name
        self.artist = performer
        self.filePathURL = filePath
    }
    
    public func getTitleFromMetadata() -> String? {
        let mp3FileURL = self.filePathURL
        let asset = AVURLAsset(url: NSURL(fileURLWithPath: mp3FileURL) as URL)
        let metaData = asset.metadata
        if let artist = metaData.first(where: {$0.commonKey == .commonKeyTitle}), let value = artist.value as? String {
            // Title
            return value
        }
        
        return nil
    }
    public func getArtistFromMetadata() -> String? {
        let mp3FileURL = self.filePathURL
        let asset = AVURLAsset(url: NSURL(fileURLWithPath: mp3FileURL) as URL)
        let metaData = asset.metadata
        if let artist = metaData.first(where: {$0.commonKey == .commonKeyArtist}), let value = artist.value as? String {
            // Artist
            return value
        }
        
        return nil
    }
    public func getAlbumFromMetadata() -> String? {
        let mp3FileURL = self.filePathURL
        let asset = AVURLAsset(url: NSURL(fileURLWithPath: mp3FileURL) as URL)
        let metaData = asset.metadata
        if let artist = metaData.first(where: {$0.commonKey == .commonKeyAlbumName}), let value = artist.value as? String {
            // Artist
            return value
        }
        
        return nil
    }
    public func getArtworkImageFromMetadata() -> UIImage? {
        let mp3FileURL = self.filePathURL
        let asset = AVURLAsset(url: NSURL(fileURLWithPath: mp3FileURL) as URL)
        let metaData = asset.metadata
        if let artist = metaData.first(where: {$0.commonKey == .commonKeyArtwork}), let value = artist.value as? Foundation.Data {
            // Artist
            return UIImage(data: value)
        }
        
        return nil
    }
}
