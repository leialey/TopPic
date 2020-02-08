//
//  Image.swift
//  TopPic
//
//  Created by Leialey on 07.02.2020.
//  Copyright © 2020 Ekaterina Rodionova. All rights reserved.
//

import Foundation

struct Image {
    let id: String
    let title: String
    let isAlbum: Bool
    let imageURL: URL?
    var comments: [String]?
}
