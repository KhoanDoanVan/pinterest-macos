//
//  Home.swift
//  Pinterest-macOS
//
//  Created by Đoàn Văn Khoan on 14/5/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct Home: View {
    
    var window = NSScreen.main?.visibleFrame
    
    @State private var search: String = ""
    var columns = Array(repeating: GridItem(.flexible(), spacing: 15), count: 4)
    
    @StateObject var imageData = ImageViewModel()
    
    var body: some View {
        VStack {
            HStack {
                SideBar()
                
                VStack {
                    HStack(spacing: 12) {
                        // Search bar
                        HStack(spacing: 15) {
                            
                            Image(systemName: "magnifyingglass")
                                .foregroundStyle(.gray)
                            
                            TextField("Search", text: $search)
                                .textFieldStyle(PlainTextFieldStyle())
                            
                            
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .background(BlurWindow())
                        .cornerRadius(10)
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "slider.vertical.3")
                                .foregroundStyle(.black)
                                .padding(10)
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
                                .shadow(color: Color.black.opacity(0.1), radius: 5, x: -5, y: -5)
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "plus")
                                .foregroundStyle(.white)
                                .padding(10)
                                .background(Color.black)
                                .cornerRadius(10)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    /// ScrollView
                    GeometryReader { reader in
                        ScrollView {
                            
                            LazyVGrid(columns: columns, spacing: 15) {
                                
                                
                                ForEach(imageData.images.indices, id: \.self) { index in
                                    
                                    ZStack {
                                        WebImage(url: URL(string: imageData.images[index].download_url)!)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: (reader.frame(in: .global).width - 45) / 4, height: 150)
                                            .cornerRadius(15)
                                            .onHover { hovering in
                                                withAnimation {
                                                    imageData.images[index].onHover = hovering
                                                }

                                            }
                                        
                                        Color.black.opacity(imageData.images[index].onHover ?? false ? 0.2 : 0)
                                        
                                        VStack {
                                            HStack {
                                                Spacer(minLength: 0)
                                                
                                                Button {
                                                    
                                                } label: {
                                                    Image(systemName: "hand.thumbsup.fill")
                                                        .foregroundStyle(.yellow)
                                                        .padding(8)
                                                        .background(Color.white)
                                                        .cornerRadius(10)
                                                }
                                                .buttonStyle(.plain)
                                                
                                                Button {
                                                    self.saveImage(index: index)
                                                } label: {
                                                    Image(systemName: "folder.fill")
                                                        .foregroundStyle(.blue)
                                                        .padding(8)
                                                        .background(Color.blue)
                                                        .cornerRadius(10)
                                                }
                                                .buttonStyle(.plain)
                                            }
                                            .padding(10)
                                            
                                            Spacer()
                                        }
                                        .opacity(imageData.images[index].onHover ?? false ? 1 : 0)
                                            
                                    }
                                }
                                
                            }
                            
                        }
                    }
                    .padding(.vertical)
                    
                    Spacer()
                }
                .padding()
            }
        }
        .ignoresSafeArea(.all, edges: .all)
        .frame(width: window!.width / 1.5, height: window!.height - 40)
        .background(Color.white.opacity(0.6))
        .background(BlurWindow())
    }
    
    
    func saveImage(index: Int) {
        
        // Getting Image data from URL...
        let manager = SDWebImageDownloader(config: .default)
        
        manager.downloadImage(with: URL(string: imageData.images[index].download_url)!) { image, _, _, _ in
            
            guard let imageoriginal = image else { return }
            
            let data = imageoriginal.sd_imageData(as: .JPEG)
            
            
            // Saving Image...
            let pannel = NSSavePanel()
            pannel.canCreateDirectories = true
            pannel.nameFieldStringValue = "\(imageData.images[index].id).jpeg"
            
            pannel.begin { response in
                
                if response.rawValue == NSApplication.ModalResponse.OK.rawValue {
                    
                    /// Saving
                    do {
                        
                        try data?.write(to: pannel.url!, options: .atomicWrite)
                        print("success")
                        
                    } catch {
                        print(error.localizedDescription)
                    }
                    
                }
                
            }
            
        }
    }
}

struct SideBar: View {
    @State var selected = "Home"
    @Namespace var animation
    
    var body: some View {
        HStack {
            VStack(spacing: 22) {
                
                Group {
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
                    .padding(.leading, 10)
                    
                    /// Tab Button
                    TabButton(image: "house.fill", title: "Home", selected: $selected, animation: animation)
                    
                    TabButton(image: "clock.fill", title: "Recents", selected: $selected, animation: animation)
                    
                    TabButton(image: "person.2.fill", title: "Following", selected: $selected, animation: animation)
                    
                    HStack {
                        Text("Insights")
                            .fontWeight(.semibold)
                            .foregroundStyle(.gray)
                        
                        Spacer()
                    }
                    .padding()
                    
                    TabButton(image: "message.fill", title: "Messages", selected: $selected, animation: animation)
                    
                    TabButton(image: "bell.fill", title: "Notifications", selected: $selected, animation: animation)
                    
                    Spacer(minLength: 0)
                }
                
                Spacer(minLength: 0)
                
                VStack(spacing: 8) {
                    Image("")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                    Button {
                        
                    } label: {
                        Text("Unlock Business Tools")
                            .fontWeight(.semibold)
                            .foregroundStyle(.blue)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Text("Hurry! Up Now you can unlock our new business tools at your convinence")
                        .foregroundStyle(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 10)
                }
                
                Spacer(minLength: 0)
                
                // Profile View...
                
                HStack(spacing: 10) {
                    Image("profile")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 32, height: 35)
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("iJustine")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundStyle(.black)
                        
                        Text("Last Login 06/12/20")
                            .font(.caption2)
                            .foregroundStyle(.gray)
                    }
                    
                    Spacer(minLength: 0)
                    
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.gray)
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 8)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: -5, y: -5)
                .padding(.horizontal)
                .padding(.bottom, 20)
                
            }
            
            
            Divider()
                .offset(x: -2)
        }
        /// Side bar default size
        .frame(width: 240)
    }
}

#Preview {
    Home()
}


extension NSTextField {
    
    open override var focusRingType: NSFocusRingType {
        get { .none }
        set {}
    }
    
}
