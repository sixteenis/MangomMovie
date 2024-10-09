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
    private let navTVButton = UIButton()
    private let navSearchButton = UIButton()
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let bigPostView = UIImageView()
    private let genreLabel = UILabel()
    private let playButton = UIButton()
    private let listButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNav()
    }
    private func setNav() {
        navTVButton.setTitle("", for: .normal)
        navTVButton.setImage(.asTv, for: .normal)
        
        navSearchButton.setTitle("", for: .normal)
        navSearchButton.setImage(.asSearch, for: .normal)
        let tv = UIBarButtonItem(customView: navTVButton)
        let search = UIBarButtonItem(customView: navSearchButton)
        navigationItem.rightBarButtonItems = [search, tv]
    }
    // MARK: - 연결 부분
    override func setUpHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        setUpBigPostViewHierarchy()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addGradientToBigPostView()
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
            make.top.equalToSuperview().inset(10)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.height.equalTo(view.frame.height / 1.7)
        }
        playButton.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview().inset(20)
            make.height.equalTo(33)
            make.width.equalTo(view.frame.width / 2 - 40)
        }
        listButton.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview().inset(20)
            make.height.equalTo(33)
            make.width.equalTo(view.frame.width / 2 - 40)
        }
        genreLabel.snp.makeConstraints { make in
            make.bottom.equalTo(listButton.snp.top).offset(-10)
            make.centerX.equalToSuperview()
        }
    }
    func setUpBigPostView() {
        bigPostView.layer.cornerRadius = 15
        bigPostView.clipsToBounds = true
        
        genreLabel.font = .font13
        genreLabel.textColor = .asFont
        genreLabel.numberOfLines = 1
        genreLabel.textAlignment = .center
        
        playButton.setImage(.asPlayFill, for: .normal)
        playButton.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 15)
        playButton.setTitle("재생", for: .normal)
        playButton.titleLabel?.font = .boldFont14
        playButton.setTitleColor(.asDarkBlack, for: .normal)
        playButton.tintColor = .asBlack
        playButton.backgroundColor = .asWhite
        playButton.layer.cornerRadius = 5
        
        listButton.setImage(.asPlus, for: .normal)
        listButton.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 15)
        listButton.titleLabel?.font = .boldFont14
        listButton.setTitle("내가 찜한 리스트", for: .normal)
        listButton.tintColor = .asWhite
        listButton.backgroundColor = .asDarkBlack
        listButton.layer.cornerRadius = 5
        
        // MARK: - 변경되는 데이터
        bigPostView.image = UIImage.testImage
        genreLabel.text = "애니메이션 가족 코미디 드라마"
        
    }
    func addGradientToBigPostView() {
        // 그라데이션 추가
        let gradient = CAGradientLayer()
        gradient.frame = bigPostView.bounds
        gradient.colors = [UIColor.clear.cgColor, UIColor.asGray.cgColor]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1.2)
        
        bigPostView.layer.insertSublayer(gradient, at: 0)
    }
}
