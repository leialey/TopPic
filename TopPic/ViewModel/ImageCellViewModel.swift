//
//  ImageCellViewModel.swift
//  TopPic
//
//  Created by Leialey on 08.02.2020.
//  Copyright © 2020 Ekaterina Rodionova. All rights reserved.
//

import Foundation

class ImageCellViewModel: ImageCellViewModelProtocol {
    var image: Image?
    
    required init(_ image: Image?) {
        self.image = image
    }
}
