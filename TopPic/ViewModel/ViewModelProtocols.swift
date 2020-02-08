//
//  ViewModelProtocols.swift
//  TopPic
//
//  Created by Leialey on 08.02.2020.
//  Copyright © 2020 Ekaterina Rodionova. All rights reserved.
//

import Foundation
import Bond

protocol ImageListViewModelProtocol {
    init()
    var images: Observable<[Image]> { get }
    var status: Observable<TaskStatus> { get }
    var itemsToDisplay: Int { get set }
    func requestImageDetails(_ row: Int) -> ImageDetailsViewModelProtocol?
    func configureCell(_ row: Int) -> ImageCellViewModelProtocol
    func loadDataIfNeeded(_ row: Int)
}

protocol ImageDetailsViewModelProtocol {
    init(_ image: Image)
    var image: Observable<Image> { get set }
    var status: Observable<TaskStatus> { get set }
    func requestDetails(_ row: Int)
}

protocol ImageCellViewModelProtocol {
    init(_ image: Image?)
    var image: Image? { get set }
}
