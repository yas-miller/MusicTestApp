//
//  MusicTestAppApp.swift
//  MusicTestApp
//
//  Created by Андрей Ясюкевич on 6.09.22.
//

import SwiftUI
import MusicCodebase
import AVFAudio
import MediaPlayer

@main
struct MusicTestAppApp: App {
    init() {
        UIApplication.shared.beginReceivingRemoteControlEvents()
        try! AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
    }
    
    @StateObject var data: MusicCodebase.Data = {
        let data = MusicCodebase.Data()
        data.loadGenericData()
        return data
    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(self.data)
        }
    }
}
