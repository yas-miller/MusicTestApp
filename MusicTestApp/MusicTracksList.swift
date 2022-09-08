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
    @ObservedObject private var musicPlayer: MusicCodebase.MusicPlayer = MusicCodebase.MusicPlayer.shared
    @State public var specifiedAuthor: MusicCodebase.Artist?
    
    var body: some View {
        VStack {
            CustomBackNavigationButton()
            
            if var musicTracks = data.musicTracks
            {
                if let specifiedAuthor = self.specifiedAuthor
                {
                    Text("Music tracks by \(specifiedAuthor.name)")
                        .font(.system(.title))
                    
                    let _ = {
                        musicTracks.filter {
                            $0.artist?.id == specifiedAuthor.id
                        }
                    }()
                }

                List(musicTracks.enumerated().map({$0}), id: \.element.id) { musicTrackIndex, musicTrack in
                    HStack {
                        Button(action: {
                            do
                            {
                                var musicTracksToQueue: [MusicTrack] = musicTracks
                                if musicTrackIndex > 0 {
                                    musicTracksToQueue.removeSubrange(0...musicTrackIndex - 1)
                                }
                                
                                musicPlayer.musicTracksQueue.removeAll()
                                musicPlayer.musicTracksQueue.append(contentsOf: musicTracksToQueue)
                                try? musicPlayer.resetAndStartPlaying()
                            }
                            catch let error
                            {
                                
                            }
                        }, label: {
                            Image(systemName: "play.circle")
                                .imageScale(.large)
                        })
                        
                        if let musicTrackTitle = musicTrack.title {
                            PushView(destination: MusicTrackDetails(musicTrack: musicTrack)) {
                                    Text(musicTrackTitle)
                                }
                        }
                    }
                }
            }
        }
    }
}
