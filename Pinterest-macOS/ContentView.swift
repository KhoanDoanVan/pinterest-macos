//
//  ContentView.swift
//  Pinterest-macOS
//
//  Created by Đoàn Văn Khoan on 14/5/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        Home()
        /// always light theme
            .preferredColorScheme(.light)
        
    }
}

#Preview {
    ContentView()
}
