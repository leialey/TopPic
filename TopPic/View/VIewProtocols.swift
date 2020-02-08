//
//  VIewProtocols.swift
//  TopPic
//
//  Created by Leialey on 08.02.2020.
//  Copyright © 2020 Ekaterina Rodionova. All rights reserved.
//

import Foundation
import SVProgressHUD

protocol StatusBindable: class {
    func bindStatus(_ status: TaskStatus)
}

extension StatusBindable {
    func bindStatus(_ status: TaskStatus) {
        
        DispatchQueue.main.async {
            switch status {
            case (let status) where status == .isRefreshing:
                SVProgressHUD.show(withStatus: status.statusDescription)
            case (let status) where status == .errorAPI || status == .errorParsing || status == .notConnectedToInternet :
                SVProgressHUD.showError(withStatus: status.statusDescription)
            case .finished:
                SVProgressHUD.dismiss()
            default:
                return
            }
        }
        
    }
}

protocol ImageListViewModelBindable {
    var viewModel: ImageListViewModelProtocol { get set }
    func bindViewModel()
}

protocol ImageDetailsViewModelBindable {
    var viewModel: ImageDetailsViewModelProtocol? { get set }
    func bindViewModel()
}

protocol ImageCellViewBindable {
    var viewModel: ImageCellViewModelProtocol? { get set }
    func bindViewModel()
}

