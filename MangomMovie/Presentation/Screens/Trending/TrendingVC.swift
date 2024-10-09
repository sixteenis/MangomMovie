//
//  TrendingVC.swift
//  MangomMovie
//
//  Created by 박성민 on 10/8/24.
//

import UIKit
import RxSwift
import RxCocoa

import SnapKit

final class TrendingVC: BaseViewController {
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let bigPostView = UIImageView()
    private let genreLabel = UILabel()
    private let playButton = UIButton()
    private let listButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // MARK: - 연결 부분
    override func setUpHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        setUpBigPostViewHierarchy()
    }
    // MARK: - 레이아웃 부분
    override func setUpLayout() {
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.bottom.equalTo(view)
        }
        contentView.snp.makeConstraints { make in
            make.width.equalTo(scrollView.snp.width)
            make.edges.equalTo(scrollView)
        }
        setUpBigPostViewLayout()
    }
    // MARK: - 데이터 부분
    override func setUpView() {
        setUpBigPostView()
    }
}
// MARK: - 큰 포스터 부분
private extension TrendingVC {
    func setUpBigPostViewHierarchy() {
        contentView.addSubview(bigPostView)
        bigPostView.addSubview(genreLabel)
        bigPostView.addSubview(playButton)
        bigPostView.addSubview(listButton)
    }
    func setUpBigPostViewLayout() {
        bigPostView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.height.equalTo(view.frame.height / 2)
        }
    }
    func setUpBigPostView() {
        bigPostView.image = UIImage(systemName: "star")
    }
}
