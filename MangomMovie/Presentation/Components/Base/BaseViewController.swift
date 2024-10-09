//
//  BaseViewController.swift
//  MangomMovie
//
//  Created by 박성민 on 10/8/24.
//

import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .asBackground
        setUpHierarchy()
        setUpView()
        setUpLayout()
        bindData()
        setUpNav()
    }
    
    func setUpHierarchy() {}
    func setUpLayout() {}
    func setUpView() {}
    func bindData() {}
    func setUpNav() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .asBackground
        appearance.shadowColor = nil
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.tintColor = .asDarkBlack
    }
}
// MARK: - 알림
extension BaseViewController {
}
// MARK: - 뷰 전환 부분
extension BaseViewController {
    func pushViewController(view: UIViewController) {
        self.navigationController?.pushViewController(view, animated: true)
    }
    func popViewController() {
        self.navigationController?.popViewController(animated: true)
    }
}


