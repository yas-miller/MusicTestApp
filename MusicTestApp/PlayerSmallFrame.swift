//
//  PlayerSmallFrame.swift
//  MusicTestApp
//
//  Created by Андрей Ясюкевич on 6.09.22.
//

import SwiftUI
import MusicCodebase

struct PlayerSmallFrame: View {
    @EnvironmentObject var data: MusicCodebase.Data
    var body: some View {
        HStack {
            if MusicPlayer.shared.isPlaying {
                Button(action: {
                    do
                    {
                        try MusicPlayer.shared.pause()
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
                        try MusicPlayer.shared.play()
                    }
                    catch let error
                    {
                        
                    }
                }, label: {
                    Image(systemName: "play.circle")
                        .imageScale(.large)
                })
            }
            
            if let nowPlayingTrack = MusicPlayer.shared.musicTracksQueue.first {
                VStack {
                    Text(nowPlayingTrack.name)
                        .bold()
                    Text(nowPlayingTrack.performer.name)
                }
                
            }
            else
            {
                Text("Not playing")
                    .font(.system(.title3))
            }
            
            Spacer()
        }
    }
}

struct PlayerSmallFrame_Previews: PreviewProvider {
    static var previews: some View {
        PlayerSmallFrame()
            .environmentObject(Data())
    }
}
