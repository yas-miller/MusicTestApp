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
        Button(action: {
            data.player.play()
        }, label: {
            Image(systemName: "play.circle")
                .imageScale(.large)
        })
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct PlayerSmallFrame_Previews: PreviewProvider {
    static var previews: some View {
        PlayerSmallFrame()
            .environmentObject(Data())
    }
}
