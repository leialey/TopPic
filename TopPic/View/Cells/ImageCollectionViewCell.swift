//
//  ImageCollectionViewCell.swift
//  TopPic
//
//  Created by Leialey on 07.02.2020.
//  Copyright © 2020 Ekaterina Rodionova. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell, ImageCellViewBindable {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageTitle: UILabel!
    
    func bindViewModel(_ viewModel: ImageCellViewModelProtocol) {
        let cellElements = [imageView, imageTitle]
        if let image = viewModel.image {
            cellElements.forEach({$0?.isHidden = false})
            imageView.loadFromURLWithPlaceholder(url: image.imageURL)
            imageTitle.text = image.title
        } else {
            cellElements.forEach({$0?.isHidden = true})
        }
    }
}
