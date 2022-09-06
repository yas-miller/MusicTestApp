//
//  ContentView.swift
//  MusicTestApp
//
//  Created by Андрей Ясюкевич on 6.09.22.
//

import SwiftUI
import MusicCodebase

struct ContentView: View {
    @EnvironmentObject var data: MusicCodebase.Data
    var body: some View {
        VStack {
            Spacer()
            
            HStack(alignment: .center) {
                PlayerSmallFrame()
            }
            .frame(minWidth: 100, maxWidth: .infinity, minHeight: 50, maxHeight: 100)
        }
        
        MusicTracksList()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(MusicCodebase.Data())
    }
}
