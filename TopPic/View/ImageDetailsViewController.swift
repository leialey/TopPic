//
//  ImageDetailsViewController.swift
//  TopPic
//
//  Created by Leialey on 07.02.2020.
//  Copyright © 2020 Ekaterina Rodionova. All rights reserved.
//

import UIKit
import Bond

class ImageDetailsViewController: UIViewController, ImageDetailsViewModelBindable, StatusBindable {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageTitle: UILabel!
    @IBOutlet weak var imageComments: UITextView!
    var viewModel: ImageDetailsViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel?.image.bind(to: self) { me, image in
            me.imageView.loadFromURLWithPlaceholder(url: image.imageURL)
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
