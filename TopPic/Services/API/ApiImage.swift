//
//  ApiImage.swift
//  TopPic
//
//  Created by Leialey on 07.02.2020.
//  Copyright © 2020 Ekaterina Rodionova. All rights reserved.
//

import Foundation

struct APIImage: ApiImageConstructor {
    private(set) var secureURL: URL?
    
    init(fileName: String?) {
        if let stringURL = fileName {
            let path = securePath(path: stringURL)
            self.secureURL = URL(string: path)
        }
    }

    //Some of the image paths are insecure http which are blocked by ATS
    private func securePath (path: String) -> String {
        if path.hasPrefix("http://") {
            return path.replacingOccurrences(of: "http://", with: "https://")
        } else {
            return path
        }
    }
}
