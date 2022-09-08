//
//  PlayerSmallFrame.swift
//  MusicTestApp
//
//  Created by Андрей Ясюкевич on 6.09.22.
//

import SwiftUI
import MusicCodebase

struct PlayerSmall: View {
    @ObservedObject private var musicPlayer: MusicPlayer = MusicPlayer.shared
    @Binding public var isPlayerFullScreenViewPresented: Bool

    var body: some View {
        ZStack {
            VisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterial))
            
            HStack {
                PlayerControls()
                
                Spacer()
                
                if let musicTrackCurrentIndexInQueue = musicPlayer.musicTrackCurrentIndexInQueue {
                    let nowPlayingTrack = musicPlayer.musicTracksQueue[musicTrackCurrentIndexInQueue]
                    VStack {
                        if let musicTrackTitle = nowPlayingTrack.title {
                            Text(musicTrackTitle)
                                .bold()
                        }
                        if let musicTrackArtistName = nowPlayingTrack.artist?.name {
                            Text(musicTrackArtistName)
                        }
                    }
                    
                }
                else
                {
                    Text("Not playing")
                        .font(.system(.title3))
                }
                
                Spacer()
            }
            .animation(Animation.interactiveSpring())
            .padding(Edge.Set.horizontal)
        }
        .onTapGesture {
            if musicPlayer.musicTrackCurrentIndexInQueue != nil {
                self.isPlayerFullScreenViewPresented.toggle()
            }
        }
    }
}
