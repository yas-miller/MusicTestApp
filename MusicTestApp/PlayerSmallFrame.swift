//
//  PlayerSmallFrame.swift
//  MusicTestApp
//
//  Created by Андрей Ясюкевич on 6.09.22.
//

import SwiftUI
import MusicCodebase

struct PlayerSmallFrame: View {
    @ObservedObject private var musicPlayer: MusicPlayer = MusicPlayer.shared

    var body: some View {
        HStack {
            if musicPlayer.isPlaying {
                Button(action: {
                    do
                    {
                        try musicPlayer.pause()
                    }
                    catch let error
                    {
                        
                    }
                }, label: {
                    Image(systemName: "pause.circle")
                        .imageScale(.large)
                })
            }
            else {
                Button(action: {
                    do
                    {
                        try musicPlayer.play()
                    }
                    catch let error
                    {
                        
                    }
                }, label: {
                    Image(systemName: "play.circle")
                        .imageScale(.large)
                })
            }
            
            if let nowPlayingTrack = musicPlayer.musicTracksQueue.first {
                VStack {
                    Text(nowPlayingTrack.name)
                        .bold()
                    Text(nowPlayingTrack.artist.name)
                }
                
            }
            else
            {
                Text("Not playing")
                    .font(.system(.title3))
            }
            
            Spacer()
        }
        .padding(Edge.Set.horizontal)
    }
}

struct PlayerSmallFrame_Previews: PreviewProvider {
    static var previews: some View {
        PlayerSmallFrame()
            .environmentObject(Data())
    }
}
