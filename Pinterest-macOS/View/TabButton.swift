//
//  TabButton.swift
//  Pinterest-macOS
//
//  Created by Đoàn Văn Khoan on 14/5/25.
//

import SwiftUI

struct TabButton: View {
    
    var image: String
    var title: String
    @Binding var selected: String
    
    var animation: Namespace.ID
    
    var body: some View {
        
        Button {
            withAnimation(.spring()) {
                selected = title
            }
        } label: {
            HStack {
                Image(systemName: image)
                    .font(.title2)
                    .foregroundStyle(selected == title ? Color.black : black)
                
                Text(title)
                    .fontWeight(selected == title ? .semibold : .none)
                    .foregroundStyle(selected == title ? Color.black : black)
                    .animation(.none)
                
                Spacer()
                
                /// Capsule
                ZStack {
                    Capsule()
                        .fill(Color.clear)
                        .frame(width: 3, height: 18)
                    
                    if selected == title {
                        Capsule()
                            .fill(Color.black)
                            .frame(width: 3, height: 18)
                            .matchedGeometryEffect(id: "Tab", in: animation)
                    }
                    
                    // comment
                }
            }
            .padding(.horizontal)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

var black = Color.black.opacity(0.5)
