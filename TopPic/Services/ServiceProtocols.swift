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
    associatedtype T
    init(_ apiEndpoint: ApiEndpoint, _ parameters: ApiRequestParameters)
    func getDataRequest() -> T
}

protocol ApiImageConstructor {
    var secureURL: URL? { get }
    init(fileName: String?)
}

protocol ApiManagement {
    var currentPage: ApiPage { get set }
    func getStatus() -> FetchStatus
    func startFetching(_ index: Int)
    func sendRequest(apiEndpoint: ApiEndpoint, parameters: ApiRequestParameters,
                     completionHandler: @escaping (Swift.Result<Any, TaskStatus>) -> Void)
}

protocol JSONParsing {
    static func parse(apiEndpoint: ApiEndpoint, jsonString: Any) -> Any?
}
