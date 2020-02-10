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
    var itemsToDisplay: Int { get }
    func requestImageDetails(_ item: Int) -> ImageDetailsViewModelProtocol?
    func getCellViewModel(_ item: Int) -> ImageCellViewModelProtocol
    func loadDataIfNeeded(_ item: Int)
}

protocol ImageDetailsViewModelProtocol {
    init(_ image: Image)
    var image: Observable<Image> { get }
    var status: Observable<TaskStatus> { get }
    func requestDetails(_ item: Int)
}

protocol ImageCellViewModelProtocol {
    var image: Image? { get }
}
