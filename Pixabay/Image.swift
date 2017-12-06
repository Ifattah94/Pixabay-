//
//  Image.swift
//  Pixabay
//
//  Created by C4Q on 12/5/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import Foundation
struct AllImageInfo: Codable {
    let hits: [PixImage]
}

struct PixImage: Codable {
    let tags: String
    let previewURL: String?
    let webformatURL: String?
    let user: String
    let id: Int
    
    
}
