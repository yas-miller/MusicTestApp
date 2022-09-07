//
//  MusicPlayer.swift
//  MusicCodebase
//
//  Created by Андрей Ясюкевич on 6.09.22.
//

import Foundation
import AVFoundation
import MediaPlayer

public class MusicPlayer: NSObject, AVAudioPlayerDelegate, ObservableObject
{
    public static var shared: MusicPlayer = {
        if instance == nil {
            instance = MusicPlayer()
        }
        return instance!
    }()
    private static var instance: MusicPlayer?
    private override init()
    {
        super.init()
    }
    
    
    
    @Published public var musicTracksQueue: [MusicTrack] = [MusicTrack]()
    @Published public var musicTracksPlayer: AVAudioPlayer?
    
    @Published public var isPlaying: Bool = false
    @Published public var currentTime: TimeInterval = TimeInterval()
    @Published public var duration: TimeInterval = TimeInterval()
    
    
    public var repeatedTimer: ResumableTimer?
    
    public func startPlayingNewMusicTrack(musicTrack: MusicTrack) throws
    {
        self.musicTracksQueue.insert(musicTrack, at: 0)
        
        try self.startPlaying()
    }
    
    public func startPlaying() throws
    {
        if let musicTrack = self.musicTracksQueue.first {
            //if musicTracksPlayer == nil
            //{
            self.musicTracksPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: musicTrack.filePathURL))
            self.setupRemoteTransportControlsSystemwise()
            self.musicTracksPlayer!.delegate = self
            self.play()
            //}
            
            self.setupNowPlayingSystemwise()
        }
    }
    
    
    public func playNextInQueue() throws {
        guard self.musicTracksQueue.count > 1 else { return }
        
        self.musicTracksQueue.removeFirst()
        
        try self.startPlaying()
    }
    public func play()
    {
        guard self.musicTracksPlayer != nil else {return}
        
        self.musicTracksPlayer!.play()
        self.isPlaying = true
        
        self.repeatedTimer = ResumableTimer(interval: 1.0, isRepeatable: true) {
            self.isPlaying = true
            self.currentTime = self.musicTracksPlayer!.currentTime
            self.duration = self.musicTracksPlayer!.duration
        }
        self.repeatedTimer!.start()
    }
    public func pause()
    {
        guard self.musicTracksPlayer != nil else {return}
        
        self.musicTracksPlayer!.pause()
        self.isPlaying = false
        
        self.repeatedTimer?.invalidate()
    }
    
    public func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        self.isPlaying = false
        
        self.musicTracksQueue.removeFirst()
        try? self.startPlaying()
   }
    
    func setupNowPlayingSystemwise() {
        // Define Now Playing Info
        var nowPlayingInfo = [String: Any]()
        nowPlayingInfo[MPMediaItemPropertyTitle] = self.musicTracksQueue.first!.getTitleFromMetadata()
        nowPlayingInfo[MPMediaItemPropertyArtist] = self.musicTracksQueue.first!.getArtistFromMetadata()
        nowPlayingInfo[MPMediaItemPropertyAlbumTitle] = self.musicTracksQueue.first!.getAlbumFromMetadata()

        if let image = self.musicTracksQueue.first!.getArtworkImageFromMetadata() {
            nowPlayingInfo[MPMediaItemPropertyArtwork] =
                MPMediaItemArtwork(boundsSize: image.size) { size in
                    return image
            }
        }
        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = Int(self.musicTracksPlayer!.currentTime.rounded())
        nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = Int(self.musicTracksPlayer!.duration.rounded())
        nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = self.musicTracksPlayer!.rate

        // Set the metadata
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }
    private func setupRemoteTransportControlsSystemwise() {
        // Get the shared MPRemoteCommandCenter
        let commandCenter = MPRemoteCommandCenter.shared()

        // Add handler for Play Command
        commandCenter.playCommand.addTarget { [unowned self] event in
            if self.musicTracksPlayer!.play() {
                return .success
            }
            return .commandFailed
        }

        // Add handler for Pause Command
        commandCenter.pauseCommand.addTarget { [unowned self] event in
            self.musicTracksPlayer!.pause()
            return .success
        }
    }
}
