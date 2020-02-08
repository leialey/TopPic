//
//  ServiceProtocols.swift
//  TopPic
//
//  Created by Leialey on 07.02.2020.
//  Copyright © 2020 Ekaterina Rodionova. All rights reserved.
//

import Foundation

protocol ApiRequestConstructor {
    associatedtype T
    init(_ apiName: ApiName, _ parameters: Any?)
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
    func sendRequest(apiName: ApiName, parameters: Any?, completionHandler: @escaping (Swift.Result<Any, TaskStatus>) -> Void)
}

protocol NetworkManagerDelegate {
    func onConnected()
}
