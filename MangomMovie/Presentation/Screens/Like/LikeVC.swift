//
//  LikeVC.swift
//  MangomMovie
//
//  Created by 박성민 on 10/8/24.
//

import UIKit
import RxSwift
import RxCocoa

import SnapKit

final class LikeVC: BaseViewController {
    private let disposeBag = DisposeBag()
    
    private let genreLabel = UILabel()
    private lazy var likeTableView = UITableView()
    
    private let testArr = Observable.just([1,2,3,4,5,6,7,8,9,10])
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func bindData() {
        testArr
            .bind(to: likeTableView.rx.items(cellIdentifier: recommendTableViewCell.id, cellType: recommendTableViewCell.self)) { (tableView, row, element) in
                element.selectionStyle = .none
            }.disposed(by: disposeBag)
        
    }
    // MARK: - 연결 부분
    override func setUpHierarchy() {
        view.addSubview(genreLabel)
        view.addSubview(likeTableView)
    }
    // MARK: - 레이아웃 부분
    override func setUpLayout() {
        genreLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(5)
        }
        likeTableView.snp.makeConstraints { make in
            make.top.equalTo(genreLabel.snp.bottom).offset(10)
            make.horizontalEdges.bottom.equalTo(view.safeAreaInsets)
        }
    }
    // MARK: - 데이터 부분
    override func setUpView() {
        self.navigationController?.navigationBar.topItem?.title = "내가 찜한 리스트"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        genreLabel.text = "영화 시리즈"
        genreLabel.font = .boldFont16
        genreLabel.textColor = .asFont
        
        likeTableView.backgroundColor = .asBackground
        likeTableView.register(recommendTableViewCell.self, forCellReuseIdentifier: recommendTableViewCell.id)
        likeTableView.rowHeight = UIScreen.main.bounds.height / 6
        likeTableView.showsVerticalScrollIndicator = false
        likeTableView.delegate = self
        likeTableView.separatorStyle = .none
        
    }
}
// MARK: - 슬라이드 삭제 구현
extension LikeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: "삭제") { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            print("삭제 클릭 됨")
            success(true)
        }
        delete.title = nil
        delete.image = .asTrsh
        delete.backgroundColor = .asRed
        return UISwipeActionsConfiguration(actions:[delete])
    }
}

