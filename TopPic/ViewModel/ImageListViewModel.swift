//
//  ImageListViewModel.swift
//  TopPic
//
//  Created by Leialey on 07.02.2020.
//  Copyright © 2020 Ekaterina Rodionova. All rights reserved.
//

import Foundation
import Bond

class ImageListViewModel: ImageListViewModelProtocol {
    
    private(set) var images = Observable<[Image]>([]) // list of images
    private var apiManager: ApiManagement
    private(set) var status = Observable<TaskStatus>(.notRunning)
    private(set) var itemsToDisplay: Int = 1 //ImageListCollectionViewController's collectionView will display total images + 1
    //if not all items are fetched from the API yet
    
    // MARK: - Public methods
    required init() {
        apiManager = ApiManager()
        NotificationCenter.default.addObserver(self, selector: #selector(networkStatusChanged),
                                               name: .connected, object: nil)
        NetworkManager.shared.startMonitoring()
    }
    
    func requestImageDetails(_ item: Int) -> ImageDetailsViewModelProtocol? {
        guard let image = images.value[safe: item] else { return nil } //user can select empty cell
        let viewModel: ImageDetailsViewModelProtocol  = ImageDetailsViewModel(image)
        viewModel.requestDetails(item)
        return viewModel
    }
    
    func getCellViewModel(_ item: Int) -> ImageCellViewModelProtocol {
        let imageCellVM: ImageCellViewModelProtocol = ImageCellViewModel(image: images.value[safe: item])
        return imageCellVM
    }
    
    func loadDataIfNeeded(_ item: Int) {
        fetchItems(item)
    }
    
    // MARK: - Private methods
    
    private func fetchItems(_ item: Int) {
        //No parallel fetching or fetching same images
        
        if images.value[safe: item] != nil || apiManager.fetchStatus == .inProgress {
            return
        }
        self.status.value = .isRefreshing
        apiManager.startFetching(item)
        
        //Start fetching
        apiManager.sendRequest(apiEndpoint: .popular, parameters: [:]) { (result) in
            switch result {
            case .success(let jsonString):
                self.parseJSON(jsonString)
            case .failure(let error):
                self.endRefresh(error)
            }
        }
    }
    
    private func endRefresh(_ status: TaskStatus) {
        self.status.value = status
    }
    
    private func parseJSON(_ jsonString: Any) {
        //there are groups of images (albums) and single images - they have different structure
        guard let newImages = JSONParser.parse(apiEndpoint: .popular, jsonString: jsonString) as? [Image] else {
            self.endRefresh(TaskStatus.errorParsing)
            return
        }
        
        //Check if all images fetched
        endRefresh(.finished)
        images.value.append(contentsOf: newImages)
        itemsToDisplay = (newImages.count == 0) ? images.value.count : images.value.count + 1
        apiManager.updateCurrentPage(itemIndex: images.value.count - 1)
    }
    
    @objc private func networkStatusChanged() {
        if let imageIndex = apiManager.getCurrentItem() {
            fetchItems(imageIndex)
        }
    }
}
