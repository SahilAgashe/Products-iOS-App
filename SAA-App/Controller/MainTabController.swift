//
//  MainTabController.swift
//  SAA-App
//
//  Created by SAHIL AGASHE on 13/07/24.
//

import UIKit

class MainTabController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myVC = MyViewController()
        myVC.tabBarItem = UITabBarItem(title: "Home", image: nil, selectedImage: nil)
        
        let productsVC = ProductsController()
        productsVC.tabBarItem = UITabBarItem(title: "Products", image: nil, selectedImage: nil)
        
        viewControllers = [productsVC , myVC]
    }
}

