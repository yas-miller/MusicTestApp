//
//  MusicTracksList.swift
//  MusicTestApp
//
//  Created by Андрей Ясюкевич on 6.09.22.
//

import SwiftUI
import MusicCodebase
import NavigationStack

struct MusicTracksList: View {
    @EnvironmentObject var data: MusicCodebase.Data
    @State public var specifiedAuthor: MusicCodebase.Performer?
    
    var body: some View {
        VStack {
            CustomBackNavigationButton()
            
            if let musicTracks = data.musicTracks
            {
                if let specifiedAuthor = self.specifiedAuthor
                {
                    List(musicTracks.filter {
                        $0.artist.id == specifiedAuthor.id
                    }) { musicTrack in
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
                            
                            PushView(destination: MusicTrackDetails(musicTrack: musicTrack)) {
                                Text(musicTrack.name)
                            }
                        }
                    }
                    .navigationTitle("Music tracks by \(specifiedAuthor.name)")
                }
                else
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
                            
                            PushView(destination: MusicTrackDetails(musicTrack: musicTrack)) {
                                Text(musicTrack.name)
                            }
                        }
                    }
                }
            }
        }
        
    }
}
