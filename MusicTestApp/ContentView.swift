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
    @State private var isPlayerFullScreenViewPresented: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                MusicTracksList()

                HStack {
                    PlayerSmallFrame()
                        .foregroundColor(.black)
                        .padding(Edge.Set.horizontal, nil)
                        .frame(minWidth: 100, maxWidth: .infinity, minHeight: 30, maxHeight: 50)
                }
                //.background(.background)
                .border(Color.gray)
                .edgesIgnoringSafeArea(.bottom)
                .animation(Animation.interactiveSpring())
                .onTapGesture {
                    self.isPlayerFullScreenViewPresented.toggle()
                }
            }
            .fullScreenCover(isPresented: $isPlayerFullScreenViewPresented) {
                PlayerFullScreen(isPlayerFullScreenViewPresented: $isPlayerFullScreenViewPresented)
            }
            .navigationTitle("MusicTestApp")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject({ () -> MusicCodebase.Data in
                let d: MusicCodebase.Data = MusicCodebase.Data()
                d.loadGenericData()
                return d
            }())
    }
}
