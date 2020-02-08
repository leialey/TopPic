//
//  ApiRequest.swift
//  TopPic
//
//  Created by Leialey on 07.02.2020.
//  Copyright © 2020 Ekaterina Rodionova. All rights reserved.
//

import Foundation
import Alamofire

struct ApiRequest: ApiRequestConstructor {
    private var baseURL: String
    private var clientID: String = AppSettings.shared.string(key: "client-id")
    private var params: Parameters?
    private var headers: HTTPHeaders?
    typealias T = DataRequest
    
    //MARK: - Public methods
    init (_ apiName: ApiName, _ parameters: Any?) {
        switch apiName {
        case .popular:
            
            guard let page = parameters as? Int else { fatalError("Page wrong format") }
            baseURL = "https://api.imgur.com/3/gallery/search/top/all/\(page)"
            params = [
                "q": "ext: png OR jpg", //just to make it simple, however there are other possible formats e.g. gif or mp4
            ]
            
            headers = [
                "Authorization": "Client-ID \(clientID)"
            ]
            
        case .details:
            guard let (imageID, isAlbum) = parameters as? (String, Bool) else { fatalError("Image parameters in wrong format") }
            let imageParent = isAlbum ? "album" : "image"
            baseURL = "https://api.imgur.com/3/gallery/\(imageParent)/\(imageID)/comments/top"
            headers = [
                "Authorization": "Client-ID \(clientID)"
            ]
        }
    }
    
    func getDataRequest() -> T {
        return Alamofire.request(self.baseURL, method: .get, parameters: self.params, headers: self.headers)
    }
}
