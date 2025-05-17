//
//  ImageModel.swift
//  Pinterest-macOS
//
//  Created by Đoàn Văn Khoan on 16/5/25.
//

import SwiftUI

struct ImageModel: Codable, Identifiable {
    
    var id: String
    var author: String
    var width: Int
    var height: Int
    var url: String
    var download_url: String
    var onHover: Bool?
}
