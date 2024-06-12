//
//  ImageModel.swift
//  ArtifyAI
//
//  Created by Hesara Mahendra on 2024-06-11.
//

import Foundation
import SwiftData

@Model
class ImageModel{
    var title: String
    var imageData: URL
    var createdAt: Date
    var imageStyle: String
    
    init(title: String, imageData: URL, createdAt: Date, imageStyle: String) {
        self.title = title
        self.imageData = imageData
        self.createdAt = createdAt
        self.imageStyle = imageStyle
    }
}
