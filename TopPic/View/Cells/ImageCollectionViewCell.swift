//
//  ImageCollectionViewCell.swift
//  TopPic
//
//  Created by Leialey on 07.02.2020.
//  Copyright © 2020 Ekaterina Rodionova. All rights reserved.
//

import UIKit
import AlamofireImage

class ImageCollectionViewCell: UICollectionViewCell, ImageCellViewBindable {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageTitle: UILabel!
    static private let imagePlaceholder = UIImage(named: "picture")
    static let filter = AspectScaledToFitSizeFilter(size: CGSize(width: UIScreen.main.bounds.size.width,
                                                               height: UIScreen.main.bounds.size.height * 0.3))
    
    func bindViewModel(_ viewModel: ImageCellViewModelProtocol) {
        let cellElements = [imageView, imageTitle]
        if let image = viewModel.image {
                cellElements.forEach({$0?.isHidden = false})
                if let imageURL = image.imageURL {
                    imageView.af_setImage(withURL: imageURL, placeholderImage: ImageCollectionViewCell.imagePlaceholder, filter: ImageCollectionViewCell.filter,
                                          imageTransition: .crossDissolve(0.2))
                } else {
                    self.imageView.image = ImageCollectionViewCell.imagePlaceholder
                }
                imageTitle.text = image.title
            } else {
                cellElements.forEach({$0?.isHidden = true})
            }
        }
    
}
