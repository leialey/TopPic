//
//  AppSettings.swift
//  TopPic
//
//  Created by Leialey on 07.02.2020.
//  Copyright © 2020 Ekaterina Rodionova. All rights reserved.
//

import Foundation

//There should be only a single instance of AppSettings - therefore using a singleton
public final class AppSettings {
    public static let shared = AppSettings()
    private var settings: [String: Any]
    
    private init() {
        guard let path = Bundle.main.path(forResource: "apiAuth", ofType: "plist"),
            let settings = NSDictionary(contentsOfFile: path) as? [String : Any] else { fatalError("plist in wrong format") }
        self.settings = settings
    }
    
    public func string(key: String) -> String {
        guard let setting = settings[key] as? String, setting != "" else { fatalError("Value not found or in a wrong format") }
        return setting
    }
}
