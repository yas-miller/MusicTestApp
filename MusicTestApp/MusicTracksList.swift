//
//  MusicTracksList.swift
//  MusicTestApp
//
//  Created by Андрей Ясюкевич on 6.09.22.
//

import SwiftUI
import MusicCodebase

struct MusicTracksList: View {
    @EnvironmentObject var data: MusicCodebase.Data
    var body: some View {
        if let musicTracks = data.musicTracks
        {
            List(musicTracks) { musicTrack in
                HStack {
                    Button(action: {
                        do
                        {
                            try MusicPlayer.shared.startPlayingNewMusicTrack(musicTrack: musicTrack)
                        }
                        catch let error
                        {
                            
                        }
                    }, label: {
                        Image(systemName: "play.circle")
                            .imageScale(.large)
                    })
                    
                    NavigationLink(musicTrack.name) {
                        MusicTrackDetails(musicTrack: musicTrack)
                    }
                }
            }
        }
    }
}
