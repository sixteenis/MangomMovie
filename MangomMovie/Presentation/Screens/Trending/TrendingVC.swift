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
    private let disposeBag = DisposeBag()
    private let vm = TrendingVM()
    
    private let navTVButton = UIButton()
    private let navSearchButton = UIButton()
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let bigPostView = UIImageView()
    private let genreLabel = UILabel()
    private let playButton = UIButton()
    private let listButton = UIButton()
    
    private let nowMovieHeader = UILabel()
    private lazy var nowMovieCollection = UICollectionView(frame: .zero, collectionViewLayout: self.horizontalColletionLayout())
    
    private let nowTVHeader = UILabel()
    private lazy var nowTVCollection = UICollectionView(frame: .zero, collectionViewLayout: self.horizontalColletionLayout())
    
    private let testArr = Observable.just([1,2,3,4,5,6,7,8,9,10])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNav()
        setUpaccessibilityIdentifier()
    }
    
    override func bindData() {
        let viewDidLoad = Observable.just(())
        let saveButtonTap = listButton.rx.tap
        let movieTap = self.nowMovieCollection.rx.modelSelected(CompactMedia.self)
            .observe(on: MainScheduler.instance)
        let tvTap = self.nowTVCollection.rx.modelSelected(CompactMedia.self)
            .observe(on: MainScheduler.instance)
        let postTap = Observable.merge(movieTap, tvTap)
        
        
        let input = TrendingVM.Input(viewDidLoad: viewDidLoad, saveButtonTap: saveButtonTap, posterTap: postTap)
        let output = vm.transform(input: input)
        playButton.rx.tap
            .bind(with: self) { owner, _ in
                print("플레이 버튼 누름")
            }.disposed(by: disposeBag)
        output.showAlert
            .bind(with: self) { owner, type in
                self.showAlert(type: type)
            }.disposed(by: disposeBag)
        output.presentDetailView
            .bind(with: self) { owner, item in
                self.presentDetatilView(model: item)
            }.disposed(by: disposeBag)
        //큰 포스터 부분
        output.bigPost
            .bind(with: self) { owner, item in
                owner.setDataBigPost(item: item)
            }.disposed(by: disposeBag)
        // 무비 부분
        output.movieList
            .bind(to: nowMovieCollection.rx.items(cellIdentifier: PosterCollectionCell.id, cellType: PosterCollectionCell.self)) { (row, element, cell) in
                cell.setUpData(data: element)
            }.disposed(by: disposeBag)
        //티비 부분
        output.tvList
            .bind(to: nowTVCollection.rx.items(cellIdentifier: PosterCollectionCell.id, cellType: PosterCollectionCell.self)) { (row, element, cell) in
                cell.setUpData(data: element)
            }.disposed(by: disposeBag)
        
        navTVButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.moveTap(2)
            }.disposed(by: disposeBag)
        navSearchButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.moveTap(1)
            }.disposed(by: disposeBag)
        
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
        setUpCollectionHierarchy()
    }
    
    // MARK: - 레이아웃 부분
    override func setUpLayout() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        contentView.snp.makeConstraints { make in
            make.width.equalTo(scrollView.snp.width)
            make.edges.equalTo(scrollView)
        }
        setUpBigPostViewLayout()
        setUpCollectionLayout()
    }
    // MARK: - 데이터 부분
    override func setUpView() {
        self.scrollView.showsVerticalScrollIndicator = false
        setUpBigPostView()
        setUpCollectionView()
    }
}
// MARK: - 네비게이션 부분
private extension TrendingVC {
    func moveTap(_ index: Int) {
        guard let tabBarController = self.tabBarController else { return }
        
        // 해당 탭으로 이동
        tabBarController.selectedIndex = index
        
//        // 네비게이션 스택을 초기화하고 싶은 경우:
//        if let navController = tabBarController.viewControllers?[targetIndex] as? UINavigationController {
//            navController.popToRootViewController(animated: true)
//        }
    }
}
// MARK: - 큰 포스터 부분
private extension TrendingVC {
    func setDataBigPost(item: CompactMedia) {
        self.fetchImage(imageView: self.bigPostView, imageURL: item.imagePath)
        // MARK: - 장르값은 코드를 주는데 그걸 변환하는 작업 필요!
        //self.genreLabel.text = item.genre.reduce("") { $0 + " " + $1}
        self.genreLabel.text = "애니메이션 가족 코미디 드라마"
    }
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
        bigPostView.isUserInteractionEnabled = true
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
        DispatchQueue.main.async {
            self.addGradientToBigPostView()
        }
    }
    func addGradientToBigPostView() {
        // 그라데이션 추가
        let gradient = CAGradientLayer()
        gradient.frame = bigPostView.bounds
        gradient.colors = [UIColor.clear.cgColor, UIColor.asGray.cgColor]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.4)
        gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        
        bigPostView.layer.insertSublayer(gradient, at: 0)
    }
}

// MARK: - 스크롤 포스터 부분
private extension TrendingVC {
    func setUpCollectionHierarchy() {
        contentView.addSubview(nowMovieHeader)
        contentView.addSubview(nowMovieCollection)
        
        contentView.addSubview(nowTVHeader)
        contentView.addSubview(nowTVCollection)
    }
    func setUpCollectionLayout() {
        nowMovieHeader.snp.makeConstraints { make in
            make.top.equalTo(bigPostView.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(10)
        }
        nowMovieCollection.snp.makeConstraints { make in
            make.top.equalTo(nowMovieHeader.snp.bottom).offset(5)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height / 5)
        }
        
        nowTVHeader.snp.makeConstraints { make in
            make.top.equalTo(nowMovieCollection.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(10)
        }
        nowTVCollection.snp.makeConstraints { make in
            make.top.equalTo(nowTVHeader.snp.bottom).offset(5)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height / 5)
            make.bottom.equalToSuperview()
        }
    }
    func setUpCollectionView() {
        self.nowTVCollection.showsHorizontalScrollIndicator = false
        self.nowMovieCollection.showsHorizontalScrollIndicator = false
        
        nowMovieHeader.text = "지금 뜨는 영화"
        nowMovieHeader.textColor = .asFont
        nowMovieCollection.backgroundColor = .asBackground
        nowMovieCollection.register(PosterCollectionCell.self, forCellWithReuseIdentifier: PosterCollectionCell.id)
        
        nowTVHeader.text = "지금 뜨는 TV 시리즈"
        nowTVHeader.textColor = .asFont
        nowTVCollection.backgroundColor = .asBackground
        nowTVCollection.register(PosterCollectionCell.self, forCellWithReuseIdentifier: PosterCollectionCell.id)
    }
    func horizontalColletionLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width / 4
        let height = UIScreen.main.bounds.height / 5
        
        layout.itemSize = CGSize(width: width, height: height)
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        
        return layout
        
    }
    
}

extension TrendingVC {
    func setUpaccessibilityIdentifier() {
        view.accessibilityIdentifier = "TrendingVC"
        self.scrollView.accessibilityIdentifier = "TrendingScrollView"
        playButton.accessibilityIdentifier = "playButton"
        listButton.accessibilityIdentifier = "listButton"
        nowMovieCollection.accessibilityIdentifier = "nowMovieCollection"
        nowTVCollection.accessibilityIdentifier = "nowTVCollection"
        navTVButton.accessibilityIdentifier = "navTVButton"
        navSearchButton.accessibilityIdentifier = "navSearchButton"
    }
}
