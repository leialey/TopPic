//
//  TaskStatus.swift
//  TopPic
//
//  Created by Leialey on 07.02.2020.
//  Copyright © 2020 Ekaterina Rodionova. All rights reserved.
//

import Foundation

public enum TaskStatus: Error {
    case notConnectedToInternet
    case errorAPI
    case errorParsing
    case isRefreshing
    case notRunning
    case finished
    
    var statusDescription: String {
        switch self {
        case .notConnectedToInternet: return "Connection error"
        case .errorAPI: return "API error"
        case .errorParsing: return "Parsing error"
        case .isRefreshing: return "Loading data..."
        case .finished: return "Finished"
        case .notRunning: return "Not running"
        }
    }
}
