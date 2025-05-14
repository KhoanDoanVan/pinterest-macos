//
//  Home.swift
//  Pinterest-macOS
//
//  Created by Đoàn Văn Khoan on 14/5/25.
//

import SwiftUI

struct Home: View {
    
    var window = NSScreen.main?.visibleFrame
    @State var selected = "Home"
    @Namespace var animation
    
    var body: some View {
        VStack {
            HStack {
                HStack {
                    VStack(spacing: 22) {
                        HStack {
                            Image("Pinterest-logo")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 45, height: 45)
                            
                            Text("Pinterest")
                                .fontWeight(.semibold)
                                .foregroundStyle(.black)
                            
                            Spacer(minLength: 0)
                        }
                        .padding(.top, 35)
                        .padding(.leading)
                        
                        /// Tab Button
                        TabButton(image: "house.fill", title: "Home", selected: $selected, animation: animation)
                        
                        TabButton(image: "clock.fill", title: "Recents", selected: $selected, animation: animation)
                        
                        TabButton(image: "person.2.fill", title: "Following", selected: $selected, animation: animation)
                        
                        Spacer(minLength: 0)
                    }
                }
                /// Side bar default size
                .frame(width: 220)
                
                Spacer()
            }
        }
        .frame(width: window!.width / 1.5, height: window!.height - 40)
        .background(Color.white.opacity(0.6))
        .background(BlurWindow())
    }
}

#Preview {
    Home()
}
