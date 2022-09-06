//
//  MusicPlayer.swift
//  MusicCodebase
//
//  Created by Андрей Ясюкевич on 6.09.22.
//

import Foundation
import AVFoundation

public class MusicPlayer: NSObject, AVAudioPlayerDelegate
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
    
    
    
    public var musicTracksQueue: [MusicTrack] = [MusicTrack]()
    private var musicTracksPlayer: AVAudioPlayer?
    public var isPlaying: Bool = false
    
    public func play() throws
    {
        if let musicTrack = self.musicTracksQueue.first {
            if musicTracksPlayer == nil
            {
                self.musicTracksPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: musicTrack.filePath))
                self.musicTracksPlayer?.delegate = self
                self.musicTracksPlayer!.play()
            }

            self.musicTracksPlayer!.play()
        }
    }
    
    public func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        self.musicTracksQueue.removeFirst()
        try? self.play()
   }
}
