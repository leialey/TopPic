//
//  ImageDetailsViewController.swift
//  TopPic
//
//  Created by Leialey on 07.02.2020.
//  Copyright © 2020 Ekaterina Rodionova. All rights reserved.
//

import UIKit
import Bond
import AlamofireImage

class ImageDetailsViewController: UIViewController, ImageDetailsViewModelBindable, StatusBindable {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageTitle: UILabel!
    @IBOutlet weak var imageComments: UITextView!
    
    var viewModel: ImageDetailsViewModelProtocol?
    private let imagePlaceholder = UIImage(named: "picture")
    let filter = AspectScaledToFitSizeFilter(size: CGSize(width: UIScreen.main.bounds.size.width,
                                                          height: UIScreen.main.bounds.size.height * 0.3))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    func bindViewModel() {
        viewModel?.image.bind(to: self) { me, image in
            if let imageURL = image.imageURL {
                me.imageView.af_setImage(withURL: imageURL, placeholderImage: me.imagePlaceholder,
                                         filter: me.filter, imageTransition: .crossDissolve(0.2))
            } else {
                me.imageView.image = me.imagePlaceholder
            }
            me.imageTitle.text = image.title
            // 1. Comment1
            // 2. Comment2
            me.imageComments.text = image.comments?.enumerated().reduce("", {"\($0)\($1.0 + 1). " + "\($1.1)\n\n"
            })
        }        
        viewModel?.status.bind(to: self) { me, status in
            me.bindStatus(status)
        }
    }
}
