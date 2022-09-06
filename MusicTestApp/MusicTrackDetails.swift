//
//  MusicTrackDetails.swift
//  MusicTestApp
//
//  Created by Андрей Ясюкевич on 6.09.22.
//

import SwiftUI
import MusicCodebase

struct MusicTrackDetails: View {
    @EnvironmentObject var data: MusicCodebase.Data
    var body: some View {
        if let musicTracks = data.musicTracks
        {
            List(musicTracks) { musicTrack in
                NavigationLink(musicTrack.name) {
                    
                }
            }
        }
    }
}
