//
//  UITabBarController.swift
//  ARKitEscavator
//
//  Created by Vitor Costa on 24/06/25.
//

import UIKit

extension UITabBarController {
    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        tabBar.layer.masksToBounds = true
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tabBar.backgroundColor = UIColor(.buttonOverlay)
        tabBar.unselectedItemTintColor = UIColor(.gray)
        tabBar.layer.borderWidth = 2
        tabBar.layer.borderColor = UIColor(.buttonStroke).cgColor

        view.bringSubviewToFront(tabBar)
    }
}
