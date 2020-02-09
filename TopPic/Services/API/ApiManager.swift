//
//  ApiManager.swift
//  TopPic
//
//  Created by Leialey on 07.02.2020.
//  Copyright © 2020 Ekaterina Rodionova. All rights reserved.
//

import Foundation

class ApiManager: ApiManagement {
    var currentPage = ApiPage() // current requested page from API
    private var fetchStatus: FetchStatus = .initial
    
    // MARK: - Public methods
    func getStatus() -> FetchStatus {
        return fetchStatus
    }
    
    func startFetching(_ index: Int) {
        if index > (currentPage.imageIndex ?? -1) {  //Requested index is greater than previous - request new page
            currentPage.pageIndex += 1
        }
        currentPage.imageIndex = index
        fetchStatus = .inProgress
    }
    
    func sendRequest(apiEndpoint: ApiEndpoint, parameters: ApiRequestParameters,
                     completionHandler: @escaping (Swift.Result<Any, TaskStatus>) -> Void) {
        let apiRequest = constructRequest(apiEndpoint, parameters)
        //Start fetching
        //Validate - response code 200..<300
        apiRequest.getDataRequest().validate().responseJSON { response in
            switch response.result {
            case .success(let jsonString):
                completionHandler(.success(jsonString))
            case .failure(let error):
                if let urlError = error as? URLError, urlError.code == .notConnectedToInternet {
                    completionHandler(.failure(.notConnectedToInternet))
                } else {
                    completionHandler(.failure(.errorAPI))
                }
            }
            self.fetchStatus = .initial
        }
    }
    // MARK: - Private methods
    private func constructRequest(_ apiEndpoint: ApiEndpoint, _ parameter: ApiRequestParameters) -> ApiRequest {
        switch apiEndpoint {
        case .popular:
            return ApiRequest(apiEndpoint, ["page": "\(currentPage.pageIndex)"])
        case .details:
            return ApiRequest(apiEndpoint, parameter)
        }
    }
}
