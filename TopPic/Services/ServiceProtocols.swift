//
//  ServiceProtocols.swift
//  TopPic
//
//  Created by Leialey on 07.02.2020.
//  Copyright © 2020 Ekaterina Rodionova. All rights reserved.
//

import Foundation

typealias ApiRequestParameters = [String: String]

protocol ApiRequestConstructor {
    associatedtype DataRequestType
    init(_ apiEndpoint: ApiEndpoint, _ parameters: ApiRequestParameters)
    //We might decide not to use Alamofire so using a generic type here
    func getDataRequest() -> DataRequestType
}

protocol ApiImageConstructor {
    var secureURL: URL? { get }
    init(fileName: String?)
}

protocol ApiManagement {
    func updateCurrentPage(itemIndex: Int)
    func getCurrentItem() -> Int?
    var fetchStatus: FetchStatus { get }
    func startFetching(_ index: Int)
    func sendRequest(apiEndpoint: ApiEndpoint, parameters: ApiRequestParameters,
                     completionHandler: @escaping (Swift.Result<Any, TaskStatus>) -> Void)
}

protocol JSONParsing {
    static func parse(apiEndpoint: ApiEndpoint, jsonString: Any) -> Any?
}
