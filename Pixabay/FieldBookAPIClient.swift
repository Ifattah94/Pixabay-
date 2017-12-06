//
//  FieldBookAPIClient.swift
//  Pixabay
//
//  Created by C4Q on 12/5/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import Foundation

enum HTTPVerb {
    case get
    case post
}


struct FieldBookAPIClient {
    private init() {}
    static let manager = FieldBookAPIClient()
    func postImg(fieldbookpost: FieldBook, completionHandler: (FieldBook) -> Void, errorHandler: (Error) -> Void) {
        let endPoint = "https://api.fieldbook.com/v1/5a25f6ad306a170300b666d4/images"
        guard var authResponse = buildAuthRequest(from: endPoint, httpVerb: .post) else {return}
        do {
            let encodedData = try JSONEncoder().encode(fieldbookpost)
            authResponse.httpBody = encodedData
            NetworkHelper.manager.performDataTask(with: authResponse, completionHandler: {print($0)}, errorHandler: {print($0)})
        }
        catch {
            errorHandler(AppError.codingError(rawError: error))
        }
        
        
    }
    private func buildAuthRequest(from url: String, httpVerb: HTTPVerb) -> URLRequest? {
        guard let url = URL(string: url) else {return nil}
        var request = URLRequest(url: url)
        let userName = "key-5"
        let password = "I2vNXkTKcUY4WUq2MgAk"
        let nameAndPassStr = "\(userName):\(password)"
        let nameAndPassData = nameAndPassStr.data(using: .utf8)!
        let authBase64Str = nameAndPassData.base64EncodedString()
        let authStr = "Basic \(authBase64Str)"
        request.addValue(authStr, forHTTPHeaderField: "Authorization")
        if httpVerb == .post {
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        return request
        
    }
    
    
}
