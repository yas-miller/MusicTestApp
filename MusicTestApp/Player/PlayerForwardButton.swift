//
//  PlayerForwardButton.swift
//  MusicTestApp
//
//  Created by Андрей Ясюкевич on 8.09.22.
//

import SwiftUI
import MusicCodebase

struct PlayerForwardButton: View {
    @ObservedObject private var musicPlayer: MusicCodebase.MusicPlayer = MusicCodebase.MusicPlayer.shared
    
    var body: some View {
        Button(action: {
            do
            {
                try musicPlayer.playNextInQueue()
            }
            catch let error
            {
                
            }
        }, label: {
            Image(systemName: "forward.circle")
                .imageScale(.large)
        })
        .disabled(musicPlayer.musicTrackCurrentIndexInQueue == nil || (musicPlayer.musicTrackCurrentIndexInQueue != nil && (0..<2).contains(musicPlayer.musicTracksQueue.count - musicPlayer.musicTrackCurrentIndexInQueue!)))
    }
}

struct PlayerForwardButton_Previews: PreviewProvider {
    static var previews: some View {
        PlayerForwardButton()
    }
}
