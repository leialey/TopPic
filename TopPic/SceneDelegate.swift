//
//  SceneDelegate.swift
//  TopPic
//
//  Created by Leialey on 07.02.2020.
//  Copyright © 2020 Ekaterina Rodionova. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        //This is a workaround for SVProgressHUD to work
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError() }
        appDelegate.window = self.window
        guard (scene as? UIWindowScene) != nil else { return }
    }
}
