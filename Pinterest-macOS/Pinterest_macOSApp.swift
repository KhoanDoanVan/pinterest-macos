//
//  Pinterest_macOSApp.swift
//  Pinterest-macOS
//
//  Created by Đoàn Văn Khoan on 14/5/25.
//

import SwiftUI

@main
struct Pinterest_macOSApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        /// hiding title bar
        .windowStyle(HiddenTitleBarWindowStyle())
    }
}
