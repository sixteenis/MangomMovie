//
//  BaseViewController.swift
//  MangomMovie
//
//  Created by 박성민 on 10/8/24.
//

import UIKit

class BaseViewController: UIViewController, FetchImageProtocol {
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
        appearance.titleTextAttributes = [.foregroundColor: UIColor.asFont]
        appearance.shadowColor = nil
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.tintColor = .asWhite
    }
}
// MARK: - 알림
extension BaseViewController {
    func showAlert(type: AlertType) {
        let alert = CustomAlert(titleText: type.title)
        self.present(alert, animated: true)
    }
}
// MARK: - 뷰 전환 부분
extension BaseViewController {
    func presentDetatilView(model: CompactMedia) {
        let vc = DetailVC()
        present(vc, animated: true)
    }
}


