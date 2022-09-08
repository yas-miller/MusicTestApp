//
//  PlayerFullScreenCarousel.swift
//  MusicTestApp
//
//  Created by Андрей Ясюкевич on 8.09.22.
//

import SwiftUI
import MusicCodebase

struct PlayerFullScreenCarousel: View {
    @ObservedObject private var musicPlayer: MusicPlayer = MusicPlayer.shared
    @State private var presentedTabIndex: Int = 0
    
    var body: some View {
        TabView(selection: self.$presentedTabIndex) {
            var i = -1
            ForEach(musicPlayer.musicTracksQueue) { musicTrack in
                let _ = { i += 1 }()
                MusicTrackArtworkImage(musicTrack: musicTrack)
                    .tag(i)
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .frame(minHeight: 300)
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        .onChange(of: self.presentedTabIndex) { newPresentedTabIndex in
            musicPlayer.musicTrackCurrentIndexInQueue = newPresentedTabIndex
            try? musicPlayer.startPlaying()
        }
        .onAppear {
            if let musicTrackCurrentIndexInQueue = musicPlayer.musicTrackCurrentIndexInQueue {
                self.presentedTabIndex = musicTrackCurrentIndexInQueue
            }
        }
        .onChange(of: self.musicPlayer.musicTrackCurrentIndexInQueue!) { newMusicTrackCurrentIndexInQueue in
            self.presentedTabIndex = newMusicTrackCurrentIndexInQueue
        }
    }
}

struct PlayerFullScreenCarousel_Previews: PreviewProvider {
    static var previews: some View {
        PlayerFullScreenCarousel()
    }
}
