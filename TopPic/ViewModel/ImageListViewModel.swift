//
//  ImageListViewModel.swift
//  TopPic
//
//  Created by Leialey on 07.02.2020.
//  Copyright © 2020 Ekaterina Rodionova. All rights reserved.
//

import Foundation
import SwiftyJSON
import Bond

class ImageListViewModel: ImageListViewModelProtocol {
    
    
    var images = Observable<[Image]>([]) // list of images
    private var apiManager: ApiManagement
    var status = Observable<TaskStatus>(.notRunning)
    var itemsToDisplay: Int = 1 //ImageListCollectionViewController's collectionView will display total images + 1 if not all items are fetched from the API yet
    
    // MARK: - Public
    required init() {
        apiManager = ApiManager()
        NotificationCenter.default.addObserver(self, selector: #selector(networkStatusChanged), name: .connected, object: nil)
        NetworkManager.shared.startMonitoring()
    }

    func requestImageDetails(_ row: Int) -> ImageDetailsViewModelProtocol? {
        guard let image = images.value[safe: row] else { return nil } //user can select empty cell
        let viewModel: ImageDetailsViewModelProtocol  = ImageDetailsViewModel(image)
        viewModel.requestDetails(row)
        return viewModel
    }
    
    func configureCell(_ row: Int) -> ImageCellViewModelProtocol {
        let imageCellVM: ImageCellViewModelProtocol = ImageCellViewModel(images.value[safe: row])
        return imageCellVM
    }
    
    func loadDataIfNeeded(_ row: Int) {
        fetchImages(row)
    }
    
    // MARK: - Private
    
    private func fetchImages(_ row: Int) {
        //No parallel fetching or fetching same images
        
        if images.value[safe: row] != nil || apiManager.getStatus() == .inProgress {
            return
        }
        self.status.value = .isRefreshing
        apiManager.startFetching(row)
        
        //Start fetching
        apiManager.sendRequest(apiName: .popular, parameters: nil) { (result) in
            switch result {
            case .success(let jsonString):
                let json = JSON(jsonString)
                self.parseJSONImages(json)
            case .failure(let error):
                self.endRefresh(error)
            }
        }
    }
    
    private func endRefresh(_ status: TaskStatus) {
        self.status.value = status
    }
    
    //We can also create a separate JSONParser service
    private func parseJSONImages(_ json: JSON) {
        //there are groups of images (albums) and single images - they have different structure
        let newImages = json["data"].arrayValue.map{Image(id: $0["id"].stringValue, title: $0["title"].stringValue, isAlbum: $0["is_album"].boolValue, imageURL: APIImage(stringURL: ($0["is_album"].boolValue == true) ? $0["images"].arrayValue[safe: 0]?["link"].stringValue : $0["link"].stringValue).secureURL)}

        //Check if all images fetched
        endRefresh(.finished)
        images.value.append(contentsOf: newImages)
        itemsToDisplay = (newImages.count == 0) ? images.value.count : images.value.count + 1
        apiManager.currentPage.imageIndex = images.value.count - 1
    }
    
    @objc private func networkStatusChanged() {
        if let imageIndex = apiManager.currentPage.imageIndex {
            fetchImages(imageIndex)
        }
    }
}
