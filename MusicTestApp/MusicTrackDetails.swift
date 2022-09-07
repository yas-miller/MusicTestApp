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
    @StateObject var musicTrack: MusicCodebase.MusicTrack
    
    var body: some View {
        VStack {
            CustomBackNavigationButton()
            Spacer()
            VStack {
                Text(musicTrack.name)
                Text(musicTrack.artist.name)
            }
            Spacer()
        }
    }
}
