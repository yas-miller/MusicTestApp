//
//  PlayerPlayPauseButton.swift
//  MusicTestApp
//
//  Created by Андрей Ясюкевич on 8.09.22.
//

import SwiftUI
import MusicCodebase

struct PlayerPlayPauseButton: View {
    @ObservedObject private var musicPlayer: MusicCodebase.MusicPlayer = MusicCodebase.MusicPlayer.shared

    var body: some View {
        if musicPlayer.isPlaying {
            Button(action: {
                musicPlayer.pause()
            }, label: {
                Image(systemName: "pause.circle")
                    .imageScale(.large)
            })
            .disabled(musicPlayer.musicTrackCurrentIndexInQueue == nil)
        }
        else {
            Button(action: {
                musicPlayer.play()
            }, label: {
                Image(systemName: "play.circle")
                    .imageScale(.large)
            })
            .disabled(musicPlayer.musicTrackCurrentIndexInQueue == nil)
        }
    }
}

struct PlayerPlayPauseButton_Previews: PreviewProvider {
    static var previews: some View {
        PlayerPlayPauseButton()
    }
}
