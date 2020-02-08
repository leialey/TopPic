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
    
    var viewModel: ImageCellViewModelProtocol? {
        didSet {
           bindViewModel()
        }
    }
    let imagePlaceholder = UIImage(named: "picture")
    
    func bindViewModel() {
        let cellElements = [imageView, imageTitle]
        if let image = viewModel?.image {
                cellElements.forEach({$0?.isHidden = false})
                if let imageURL = image.imageURL {
                    imageView.af_setImage(withURL: imageURL, placeholderImage: self.imagePlaceholder, imageTransition: .crossDissolve(0.2))
                } else {
                    self.imageView.image = self.imagePlaceholder
                }
                imageTitle.text = image.title
            } else {
                cellElements.forEach({$0?.isHidden = true})
            }
        }
    
}
