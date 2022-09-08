//
//  PlayerBackwardButton.swift
//  MusicTestApp
//
//  Created by Андрей Ясюкевич on 8.09.22.
//

import SwiftUI
import MusicCodebase

struct PlayerBackwardButton: View {
    @ObservedObject private var musicPlayer: MusicCodebase.MusicPlayer = MusicCodebase.MusicPlayer.shared
    
    var body: some View {
        Button(action: {
            do
            {
                try musicPlayer.playPreviousInQueue()
            }
            catch let error
            {
                
            }
        }, label: {
            Image(systemName: "backward.circle")
                .imageScale(.large)
        })
        .disabled(musicPlayer.musicTrackCurrentIndexInQueue == nil || (musicPlayer.musicTrackCurrentIndexInQueue != nil && musicPlayer.musicTrackCurrentIndexInQueue! == 0))
    }
}

struct PlayerBackwardButton_Previews: PreviewProvider {
    static var previews: some View {
        PlayerBackwardButton()
    }
}
