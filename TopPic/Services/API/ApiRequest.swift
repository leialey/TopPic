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

    // MARK: - Public methods
    init (_ apiEndpoint: ApiEndpoint, _ parameters: ApiRequestParameters) {
        switch apiEndpoint {
        case .popular:
            baseURL = "https://api.imgur.com/3/gallery/search/top/all/<page>"
            params = [
                "q": "ext: png OR jpg"
                //just to make it simple, however there are other possible formats e.g. gif or mp4
            ]
            headers = [
                "Authorization": "Client-ID \(clientID)"
            ]
        case .details:
            baseURL = "https://api.imgur.com/3/gallery/<albumImage>/<imageID>/comments/top"
            headers = [
                "Authorization": "Client-ID \(clientID)"
            ]
        }
        baseURL = constructBaseURL(&baseURL, parameters)
    }
    
    func getDataRequest() -> T {
        return Alamofire.request(self.baseURL, method: .get, parameters: self.params, headers: self.headers)
    }
    // MARK: - Private methods
    private func constructBaseURL(_ baseURL: inout String, _ parameters: ApiRequestParameters) -> String {
        parameters.forEach { (key, value) in
            baseURL = baseURL.replacingOccurrences(of: "<\(key)>", with: value)
        }
        return baseURL
    }
}
