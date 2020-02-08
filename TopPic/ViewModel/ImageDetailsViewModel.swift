//
//  ImageDetailsViewModel.swift
//  TopPic
//
//  Created by Leialey on 07.02.2020.
//  Copyright © 2020 Ekaterina Rodionova. All rights reserved.
//

import Foundation
import SwiftyJSON
import Bond

class ImageDetailsViewModel: ImageDetailsViewModelProtocol {
    var image: Observable<Image>
    var status = Observable<TaskStatus>(.notRunning)
    private let apiManager: ApiManagement
    
    // MARK: - Public
    required init(_ image: Image) {
        self.image = Observable(image)
        apiManager = ApiManager()
    }
    
    func requestDetails(_ row: Int) {
        status.value = .isRefreshing
        apiManager.sendRequest(apiName: .details, parameters: (self.image.value.id, self.image.value.isAlbum)) { (result) in
            switch result {
            case .success(let jsonString):
                let json = JSON(jsonString)
                if let comments = self.parseJSONVideo(json) {
                    self.image.value.comments = comments
                }
                self.endRefreshing(.finished)
            case .failure(let error):
                self.endRefreshing(error)
            }
        }
    }
    
    // MARK: - Private
    private func parseJSONVideo(_ json: JSON) -> [String]? {
        return json["data"].arrayValue.map({$0["comment"].stringValue})
    }
    
    private func endRefreshing(_ status: TaskStatus) {
        self.status.value = status
    }
    
}
