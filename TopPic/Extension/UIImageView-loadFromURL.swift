//
//  UIImageView-loadFromURL.swift
//  TopPic
//
//  Created by Leialey on 09.02.2020.
//  Copyright © 2020 Ekaterina Rodionova. All rights reserved.
//

import Foundation
import AlamofireImage

//A small Facade (or Decorator) to simplify Alamofireimage method call, we also provide the same default image filter to reduce its size (and save memory)
extension UIImageView {
    
    func loadFromURLWithPlaceholder(url: URL?,
                                    placeholderImage: UIImage = UIImage(named: "picture") ?? UIImage(),
                                    filter: AspectScaledToFitSizeFilter =
        AspectScaledToFitSizeFilter(size: CGSize(width: UIScreen.main.bounds.size.width,
                                                 height: UIScreen.main.bounds.size.height * 0.3))) {
        if let url = url {
            self.af_setImage(withURL: url, placeholderImage: placeholderImage, filter: filter,
                             imageTransition: .crossDissolve(0.2))
        } else {
            self.image = placeholderImage
        }
    }
    
}
