//
//  ImageDetailsViewModel.swift
//  TopPic
//
//  Created by Leialey on 07.02.2020.
//  Copyright © 2020 Ekaterina Rodionova. All rights reserved.
//

import Foundation
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
    
    func requestDetails(_ item: Int) {
        status.value = .isRefreshing
        let parameters: ApiRequestParameters = [
            "albumImage": self.image.value.isAlbum ? "album" : "image",
            "imageID": self.image.value.id
        ]
        apiManager.sendRequest(apiEndpoint: .details,
                               parameters: parameters) { (result) in
            switch result {
            case .success(let jsonString):
                if let comments = self.parseJSON(jsonString) {
                    self.image.value.comments = comments
                }
                self.endRefreshing(.finished)
            case .failure(let error):
                self.endRefreshing(error)
            }
        }
    }
    
    // MARK: - Private
    private func parseJSON(_ jsonString: Any) -> [String]? {
        guard let comments = JSONParser.parse(apiEndpoint: .details, jsonString: jsonString) as? [String] else {
            self.endRefreshing(TaskStatus.errorParsing)
            return nil
        }
        return comments
    }
    
    private func endRefreshing(_ status: TaskStatus) {
        self.status.value = status
    }
    
}
