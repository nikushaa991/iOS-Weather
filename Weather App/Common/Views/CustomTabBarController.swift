//
//  CustomTabBarController.swift
//  Weather App
//
//  Created by Nika Nasaridze on 2/6/21.
//

import UIKit

class CustomTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundImage = .init()
        tabBar.shadowImage = .init()
        tabBar.unselectedItemTintColor = .white
    }
}
