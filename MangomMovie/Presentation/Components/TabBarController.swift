//
//  TabBarController.swift
//  MangomMovie
//
//  Created by 박성민 on 10/8/24.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = .asWhite
        tabBar.unselectedItemTintColor = .asGray
        tabBar.backgroundColor = .asDarkBlack
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .asDarkBlack
        
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        
        let Trending = TrendingVC()
        let Search = SearchVC()
        let Like = LikeVC()
        
        let TrendingNav = UINavigationController(rootViewController: Trending)
        TrendingNav.tabBarItem = UITabBarItem(title: "Home", image: .ashome, tag: 0)
        
        let SearchNav = UINavigationController(rootViewController: Search)
        SearchNav.tabBarItem = UITabBarItem(title: "Top Search", image: .asSearch, tag: 1)
        
        let LikeNav = UINavigationController(rootViewController: Like)
        LikeNav.tabBarItem = UITabBarItem(title: "Download", image: .asSmailing, tag: 2)
        
        setViewControllers([TrendingNav, SearchNav, LikeNav], animated: false)
    }
}
