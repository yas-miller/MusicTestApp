//
//  MusicTestAppApp.swift
//  MusicTestApp
//
//  Created by Андрей Ясюкевич on 6.09.22.
//

import SwiftUI
import MusicCodebase

@main
struct MusicTestAppApp: App {
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
