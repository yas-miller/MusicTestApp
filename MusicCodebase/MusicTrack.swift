//
//  MusicTrack.swift
//  MusicCodebase
//
//  Created by Андрей Ясюкевич on 6.09.22.
//

import Foundation
import AVFoundation

public class MusicTrack: ObservableObject, Identifiable, Codable
{
    @Published public var id: UUID
    @Published public var title: String?
    @Published public var artist: Artist?
    @Published public var album: String?
    @Published public var artworkImageBinaryData: Foundation.Data?
    
    @Published public var fileName: String
    public lazy var filePathURLString: String? = {
        var musicCodebaseBundle = Bundle(for: type(of: self))
        var path = musicCodebaseBundle.path(forResource: URL(fileURLWithPath: self.fileName).deletingPathExtension().lastPathComponent,
                                            ofType: URL(fileURLWithPath: self.fileName).pathExtension)
        return path
    }()

    public init(title: String, artist: Artist, fileName: String) {
        self.id = UUID()
        self.title = title
        self.artist = artist
        self.fileName = fileName
    }
    public init(title: String, artist: Artist, album: String, fileName: String) {
        self.id = UUID()
        self.title = title
        self.artist = artist
        self.album = album
        self.fileName = fileName
    }
    // Automatically parse metadata
    public init(fileName: String) {
        self.id = UUID()
        self.fileName = fileName
        
        try? self.getTitleFromMetadata()
        try? self.getArtistFromMetadata()
        try? self.getAlbumFromMetadata()
        //try? self.getArtworkImageBinaryDataFromMetadata()
    }
    
    public func getTitleFromMetadata() throws {
        if let mp3FileURL = self.filePathURLString {
            let asset = AVURLAsset(url: URL(fileURLWithPath: mp3FileURL))
            let metaData = asset.metadata
            if let title = metaData.first(where: {$0.commonKey == .commonKeyTitle}), let value = title.value as? String {
                // Title
                self.title = value.stringByDecodingHTMLEntities
            }
        }
        else {
            throw NSError()
        }
    }
    public func getArtistFromMetadata() throws {
        if let mp3FileURL = self.filePathURLString {
            let asset = AVURLAsset(url: URL(fileURLWithPath: mp3FileURL))
            let metaData = asset.metadata
            if let artist = metaData.first(where: {$0.commonKey == .commonKeyArtist}), let value = artist.value as? String {
                // Artist
                self.artist = Artist.GetArtistByName(name: value.stringByDecodingHTMLEntities)
            }
        }
        else {
            throw NSError()
        }
    }
    public func getAlbumFromMetadata() throws {
        if let mp3FileURL = self.filePathURLString {
            let asset = AVURLAsset(url: URL(fileURLWithPath: mp3FileURL))
            let metaData = asset.metadata
            if let album = metaData.first(where: {$0.commonKey == .commonKeyAlbumName}), let value = album.value as? String {
                // Artist
                self.album = value.stringByDecodingHTMLEntities
            }
        }
        else {
            throw NSError()
        }
    }
    public func getArtworkImageBinaryDataFromMetadata() throws {
        if let mp3FileURL = self.filePathURLString {
            let asset = AVURLAsset(url: URL(fileURLWithPath: mp3FileURL))
            let metaData = asset.metadata
            if let artworkImageBinaryData = metaData.first(where: {$0.commonKey == .commonKeyArtwork}), let value = artworkImageBinaryData.value as? Foundation.Data {
                // Artist
                self.artworkImageBinaryData = value
            }
        }
        else {
            throw NSError()
        }
    }
}
