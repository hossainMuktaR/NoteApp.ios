//
//  NoteApp_iosApp.swift
//  NoteApp.ios
//
//  Created by Hossain Muktar on 24/8/24.
//

import SwiftUI
import SwiftData

@main
struct NoteApp_iosApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [
                    Note.self
                ])
        }
    }
}
