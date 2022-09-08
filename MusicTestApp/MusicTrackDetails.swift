//
//  MusicTrackDetails.swift
//  MusicTestApp
//
//  Created by Андрей Ясюкевич on 6.09.22.
//

import SwiftUI
import MusicCodebase
import NavigationStack

struct MusicTrackDetails: View {
    @EnvironmentObject var data: MusicCodebase.Data
    @StateObject var musicTrack: MusicCodebase.MusicTrack
    @EnvironmentObject private var navigationStack: NavigationStackCompat
    
    var body: some View {
        VStack {
            CustomBackNavigationButton()
            Spacer()
            VStack {
                MusicTrackArtworkImage(musicTrack: musicTrack)
                if let musicTrackTitle = musicTrack.title {
                    Text(musicTrackTitle)
                        .bold()
                }
                if let musicTrackAlbumName = musicTrack.album {
                    Text(musicTrackAlbumName)
                }
                if let musicTrackArtistName = musicTrack.artist?.name {
                    Button(musicTrackArtistName) {
                        self.navigationStack.pop()
                        self.navigationStack.push(MusicTracksList(specifiedAuthor: musicTrack.artist))
                    }
                }
            }
            Spacer()
        }
        .padding()
    }
}
