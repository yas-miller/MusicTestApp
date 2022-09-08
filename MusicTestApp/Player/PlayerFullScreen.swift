//
//  PlayerFullScreen.swift
//  MusicTestApp
//
//  Created by Андрей Ясюкевич on 6.09.22.
//

import SwiftUI
import MusicCodebase
import NavigationStack

struct PlayerFullScreen: View {
    @Binding public var isViewPresented: Bool
    @State private var appeared: Double = 0
    @ObservedObject private var musicPlayer: MusicPlayer = MusicPlayer.shared
    @EnvironmentObject private var navigationStack: NavigationStackCompat
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    self.isViewPresented.toggle()
                }, label: {
                    Image(systemName: "xmark.circle")
                        .imageScale(.large)
                        .foregroundColor(.black)
                })
                Spacer()
            }
            Text("Now playing")
                .font(.system(.title3))
            VStack {
                if let musicTrackCurrentIndexInQueue = musicPlayer.musicTrackCurrentIndexInQueue {
                    let nowPlayingTrack = musicPlayer.musicTracksQueue[musicTrackCurrentIndexInQueue]
                    
                    PlayerFullScreenCarousel()
                    
                    Spacer()
                    
                    if let nowPlayingTrackTitle = nowPlayingTrack.title {
                        Text(nowPlayingTrackTitle)
                            .bold()
                    }
                    if let nowPlayingTrackAlbumName = nowPlayingTrack.album {
                        Text(nowPlayingTrackAlbumName)
                    }
                    if let nowPlayingTrackArtistName = nowPlayingTrack.artist?.name {
                        Button(nowPlayingTrackArtistName) {
                            self.isViewPresented = false
                            self.navigationStack.push(MusicTracksList(specifiedAuthor: nowPlayingTrack.artist))
                        }
                    }
                    
                }
                
                Slider(value: $musicPlayer.currentTime, in: 0...musicPlayer.duration) {editing in
                    if !editing {
                        print(musicPlayer.currentTime)
                        musicPlayer.musicTracksPlayer?.currentTime = TimeInterval(musicPlayer.currentTime)
                        
                        musicPlayer.repeatedTimer?.resume()
                    }
                    else
                    {
                        musicPlayer.repeatedTimer?.pause()
                    }
                }
                
                HStack {
                    Text(String(format: "%02d:%02d", (Int)(musicPlayer.currentTime) / 60, (Int)(musicPlayer.currentTime) % 60))
                    Spacer()
                    Text(String(format: "%02d:%02d", (Int)(musicPlayer.duration) / 60, (Int)(musicPlayer.duration) % 60))
                }

                PlayerControls()
            }
            .opacity(appeared)
            .animation(Animation.easeInOut(duration: 1.0), value: appeared)
            .onAppear {self.appeared = 1.0}
            .onDisappear {self.appeared = 0.0}
            
            Spacer()
        }
        .padding()
    }
}
