//
//  Pix API Client.swift
//  Pixabay
//
//  Created by C4Q on 12/5/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import Foundation
class PixAPIClient {
    private init() {}
    static let manager = PixAPIClient()
    func getPix(named searchStr: String, completionHandler: @escaping ([PixImage]) -> Void, errorHandler: @escaping (AppError) -> Void) {
        let urlStr = "https://pixabay.com/api/?key=7289812-63a2aed251a84a396c3d3d4a9&q=\(searchStr)&image_type=photo"
        
         let url = URLRequest(url: URL(string: urlStr)!)
        let completion: (Data) -> Void = {(data: Data) in
            do {
                let pixInfo = try JSONDecoder().decode(AllImageInfo.self, from: data)
                let pix = pixInfo.hits
                completionHandler(pix)
            }
            catch let error {
                print(error)
            }
        }
        NetworkHelper.manager.performDataTask(with: url, completionHandler: completion, errorHandler: errorHandler)
        
    }
    
    
    
    
}
