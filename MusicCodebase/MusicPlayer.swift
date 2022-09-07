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
    
    
    private var repeatedTimer: Timer?
    
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
            self.musicTracksPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: musicTrack.filePath))
            self.setupRemoteTransportControls()
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
        
        self.repeatedTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            self.isPlaying = true
            self.currentTime = self.musicTracksPlayer!.currentTime
            self.duration = self.musicTracksPlayer!.duration
        })
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
    
    public func getCurrentMusicTrackTitleFromMetadata() -> String? {
        guard !self.musicTracksQueue.isEmpty else { return nil }
        
        let systemMP: MPMusicPlayerController & MPSystemMusicPlayerController = MPMusicPlayerController.systemMusicPlayer;
        let currentPlayingItem: MPMediaItem? = systemMP.nowPlayingItem;
        let title: String? = currentPlayingItem?.title

        return title
    }
    public func getCurrentMusicTrackArtistFromMetadata() -> String? {
        guard !self.musicTracksQueue.isEmpty else { return nil }
        
        let systemMP: MPMusicPlayerController & MPSystemMusicPlayerController = MPMusicPlayerController.systemMusicPlayer;
        let currentPlayingItem: MPMediaItem? = systemMP.nowPlayingItem;
        let artist: String? = currentPlayingItem?.artist
        return artist
    }
    public func getCurrentMusicTrackArtworkImageFromMetadata() -> UIImage? {
        guard !self.musicTracksQueue.isEmpty else { return nil }
        
        let systemMP: MPMusicPlayerController & MPSystemMusicPlayerController = MPMusicPlayerController.systemMusicPlayer;
        let currentPlayingItem: MPMediaItem? = systemMP.nowPlayingItem;
        let artworkImage: UIImage? = currentPlayingItem?.artwork?.image(at: CGSize(width: 200, height: 200));
        
        return artworkImage
    }
    
    func setupNowPlayingSystemwise() {
        // Define Now Playing Info
        var nowPlayingInfo = [String: Any]()
        nowPlayingInfo[MPMediaItemPropertyTitle] = "My Movie"

        if let image = self.getCurrentMusicTrackArtworkImageFromMetadata() {
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
    
    private func setupRemoteTransportControls() {
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
