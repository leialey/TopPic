//
//  JSONParser.swift
//  TopPic
//
//  Created by Leialey on 08.02.2020.
//  Copyright © 2020 Ekaterina Rodionova. All rights reserved.
//

import Foundation
import SwiftyJSON

struct JSONParser: JSONParsing {
    static func parse(apiEndpoint: ApiEndpoint, jsonString: Any) -> Any? {
        let json = JSON(jsonString)
        switch apiEndpoint {
        case.popular:
            return json["data"].arrayValue.map {Image(id: $0["id"].stringValue,
            title: $0["title"].stringValue,
            isAlbum: $0["is_album"].boolValue,
            imageURL: APIImage(fileName: ($0["is_album"].boolValue == true) ?
                $0["images"].arrayValue[safe: 0]?["link"].stringValue : $0["link"].stringValue).secureURL)}
        case .details:
            return json["data"].arrayValue.map({$0["comment"].stringValue})
        }
    }
}
