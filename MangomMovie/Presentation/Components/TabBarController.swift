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
        
        let trendingVC = TrendingVC()
        let searchVC = SearchVC()
        let likeVC = LikeVC()
        
        
        let trendingNav = UINavigationController(rootViewController: trendingVC)
        trendingNav.tabBarItem = UITabBarItem(title: "Home", image: .ashome, tag: 0)
        trendingNav.tabBarItem.accessibilityIdentifier = "trendingTab" 
        
        let searchNav = UINavigationController(rootViewController: searchVC)
        searchNav.tabBarItem = UITabBarItem(title: "Top Search", image: .asSearch, tag: 1)
        searchNav.tabBarItem.accessibilityIdentifier = "searchTab"
        
        let likeNav = UINavigationController(rootViewController: likeVC)
        likeNav.tabBarItem = UITabBarItem(title: "Download", image: .asSmailing, tag: 2)
        likeNav.tabBarItem.accessibilityIdentifier = "likeTab"
        
        // 탭 바에 뷰 컨트롤러 설정
        setViewControllers([trendingNav, searchNav, likeNav], animated: false)
    }
}
