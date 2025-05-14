//
//  BlurWindow.swift
//  Pinterest-macOS
//
//  Created by Đoàn Văn Khoan on 14/5/25.
//

import SwiftUI


struct BlurWindow: NSViewRepresentable {
    
    func makeNSView(context: Context) -> NSVisualEffectView {
        
        let view = NSVisualEffectView()
        view.blendingMode = .behindWindow
        
        return view
        
    }
    
    func updateNSView(_ nsView: NSVisualEffectView, context: Context) {
        
    }
    
}
