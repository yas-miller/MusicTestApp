//
//  ContentView.swift
//  MusicTestApp
//
//  Created by Андрей Ясюкевич on 6.09.22.
//

import SwiftUI
import MusicCodebase
import NavigationStack

struct ContentView: View {
    @EnvironmentObject var data: MusicCodebase.Data
    @State private var isPlayerFullScreenViewPresented: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            NavigationStackView {
                MusicTracksList()
                    .navigationTitle("MusicTestApp")
                    .fullScreenCover(isPresented: $isPlayerFullScreenViewPresented) {
                        PlayerFullScreen(isViewPresented: $isPlayerFullScreenViewPresented)
                    }
            }

            VisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterial))
                .frame(minWidth: 100, maxWidth: .infinity, minHeight: 30, maxHeight: 70)
                .edgesIgnoringSafeArea(.bottom)

            
            PlayerSmallFrame()
                .foregroundColor(.black)
                .frame(minWidth: 100, maxWidth: .infinity, minHeight: 30, maxHeight: 70)
                .animation(Animation.interactiveSpring())
                .onTapGesture {
                    self.isPlayerFullScreenViewPresented.toggle()
                }
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
