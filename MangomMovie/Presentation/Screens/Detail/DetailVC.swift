//
//  DetailVC.swift
//  MangomMovie
//
//  Created by 박성민 on 10/9/24.
//

import UIKit
import RxSwift
import RxCocoa

import SnapKit

final class DetailVC: BaseViewController {
    private let disposeBag = DisposeBag()
    
    private let xButton = UIButton()
    private let tvButton = UIButton()
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let poster = UIImageView()
    private let asTitle = UILabel()
    private let grade = UILabel()
    
    private let playButton = UIButton()
    private let saveButton = UIButton()
    private let content = UILabel()
    private let actorContent = UILabel()
    
    private let recommendHeader = UILabel()
    private lazy var recommendCollectionView = UICollectionView(frame: .zero, collectionViewLayout: self.recommendCollectionLayout())
    private let emptyView = UIView()
    
    private var testArrs = Observable.just([1,2,3,4,5,6,7,8,9,10])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSheet()
        scrollView.isScrollEnabled = true
        scrollView.alwaysBounceVertical = true
        recommendCollectionView.isScrollEnabled = false
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.contentSize = contentView.frame.size
        scrollView.layoutIfNeeded() // 레이아웃 강제 적용
        xButton.layer.cornerRadius = xButton.frame.height / 2
        tvButton.layer.cornerRadius = tvButton.frame.height / 2
    }
    private func configureSheet() {
        if let sheet = self.sheetPresentationController {
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.detents = [.large()]
            sheet.prefersGrabberVisible = true
        }
    }
    override func bindData() {
        //테스트용 임시 무비
        testArrs
            .bind(to: recommendCollectionView.rx.items(cellIdentifier: PosterCollectionCell.id, cellType: PosterCollectionCell.self)) { (row, element, cell) in
                
            }.disposed(by: disposeBag)
        
        xButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.dismiss(animated: true)
            }.disposed(by: disposeBag)
        
    }
    
    // MARK: - 연결 부분
    override func setUpHierarchy() {
        view.addSubview(poster)
        view.addSubview(scrollView)
        poster.addSubview(tvButton)
        poster.addSubview(xButton)
        
        scrollView.addSubview(contentView)
        //contentView.addSubview(poster)
        contentView.addSubview(asTitle)
        contentView.addSubview(grade)
        contentView.addSubview(playButton)
        contentView.addSubview(saveButton)
        contentView.addSubview(content)
        contentView.addSubview(actorContent)
        
        contentView.addSubview(recommendHeader)
        contentView.addSubview(recommendCollectionView)
        contentView.addSubview(emptyView)
    }
    // MARK: - 레이아웃 부분
    override func setUpLayout() {
        poster.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(view.frame.height / 3.5)
        }
        xButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(10)
            make.size.equalTo(33)
        }
        tvButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.trailing.equalTo(xButton.snp.leading).offset(-10)
            make.size.equalTo(33)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(poster.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view)
        }
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView) // 스크롤뷰와 동일한 경계
            make.width.equalTo(scrollView) // 가로 크기 고정
            make.height.greaterThanOrEqualTo(scrollView.snp.height) // 최소 높이 설정
        }
        
        asTitle.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
            make.top.equalTo(contentView).inset(5)
        }
        grade.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
            make.top.equalTo(asTitle.snp.bottom).offset(5)
        }
        playButton.snp.makeConstraints { make in
            make.top.equalTo(grade.snp.bottom).offset(15)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.height.equalTo(33)
        }
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(playButton.snp.bottom).offset(15)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.height.equalTo(33)
        }
        content.snp.makeConstraints { make in
            make.top.equalTo(saveButton.snp.bottom).offset(15)
            make.horizontalEdges.equalToSuperview().inset(10)
        }
        actorContent.snp.makeConstraints { make in
            make.top.equalTo(content.snp.bottom)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.height.equalTo(50)
        }
        recommendHeader.snp.makeConstraints { make in
            make.top.equalTo(actorContent.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(10)
        }
        recommendCollectionView.snp.makeConstraints { make in
            make.top.equalTo(recommendHeader.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.height.equalTo(UIScreen.main.bounds.height / 2)
            
        }
        emptyView.snp.makeConstraints { make in
            make.top.equalTo(recommendCollectionView.snp.bottom)
            make.horizontalEdges.bottom.equalToSuperview()
            make.height.equalTo(10)
        }
        
    }
    // MARK: - 데이터 부분
    override func setUpView() {
        poster.isUserInteractionEnabled = true
        
        xButton.setImage(.xMark, for: .normal)
        xButton.setTitleColor(.asWhite, for: .normal)
        xButton.backgroundColor = .asDarkBlack
        xButton.layer.masksToBounds = true
        xButton.tintColor = .asFont
        xButton.layer.opacity = 0.8
        
        tvButton.setImage(.asTv, for: .normal)
        tvButton.setTitleColor(.asWhite, for: .normal)
        tvButton.backgroundColor = .asDarkBlack
        tvButton.layer.masksToBounds = true
        tvButton.tintColor = .asFont
        tvButton.layer.opacity = 0.8
        
        asTitle.font = .boldFont18
        asTitle.textAlignment = .left
        asTitle.numberOfLines = 1
        asTitle.textColor = .asFont
        
        grade.font = .font13
        grade.textAlignment = .left
        grade.numberOfLines = 1
        grade.textColor = .asFont
        
        playButton.setImage(.asPlayFill, for: .normal)
        playButton.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 15)
        playButton.setTitle("재생", for: .normal)
        playButton.titleLabel?.font = .boldFont14
        playButton.setTitleColor(.asDarkBlack, for: .normal)
        playButton.tintColor = .asBlack
        playButton.backgroundColor = .asWhite
        playButton.layer.cornerRadius = 10
        
        saveButton.setImage(.asDown, for: .normal)
        saveButton.imageEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 15)
        saveButton.titleLabel?.font = .boldFont14
        saveButton.setTitle("저장", for: .normal)
        saveButton.tintColor = .asWhite
        saveButton.backgroundColor = .asDarkBlack
        saveButton.layer.cornerRadius = 10
        
        content.font = .font14
        content.textColor = .asFont
        content.numberOfLines = 0
        content.textAlignment = .left
        
        actorContent.font = .font14
        actorContent.textColor = .asPlaceholder
        actorContent.numberOfLines = 0
        actorContent.textAlignment = .left
        
        recommendHeader.font = .boldFont15
        recommendHeader.textAlignment = .left
        recommendHeader.text = "비슷한 콘텐츠"
        recommendHeader.textColor = .asFont
        
        recommendCollectionView.backgroundColor = .asBackground
        recommendCollectionView.register(PosterCollectionCell.self, forCellWithReuseIdentifier: PosterCollectionCell.id)
        recommendCollectionView.showsVerticalScrollIndicator = false
        
        emptyView.backgroundColor = .asBackground
        setUpData()
    }
    
}
// MARK: - 임시 데이터 세팅 부분
private extension DetailVC {
    func setUpData() {
        poster.image = .test
        asTitle.text = "인사이드 아웃2"
        grade.text = "7.3"
        content.text = """
        13살이 된 라일리의 행복을 위해 매일 바쁘게 머릿속 감정 컨트롤 본부를 운영하는 ‘기쁨’, ‘슬픔’, ‘버럭’, ‘까칠’, ‘소심’. 그러던 어느 날, 낯선 감정인 ‘불안’, ‘당황’, ‘따분’, ‘부럽’이가 본부에 등장하고, 언제나 최악의 상황을 대비하며 제멋대로인 ‘불안’이와 기존 감정들은 계속 충돌한다. 결국 새로운 감정들에 의해 본부에서 쫓겨나게 된 기존 감정들은 다시 본부로 돌아가기 위해 위험천만한 모험을 시작하는데…
        """
        actorContent.text = "출연: 톰 홀로드 어쩌구 저쩌구인사람!"
    }
}

// MARK: - 레이아웃 부분
private extension DetailVC {
    func recommendCollectionLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width / 3 - 10
        let height = UIScreen.main.bounds.height / 4
        
        layout.itemSize = CGSize(width: width, height: height)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 15, left: 0, bottom: 10, right: 0)
        
        layout.minimumLineSpacing = 5 // 세로 간격 (셀 간의 줄 간격)
        layout.minimumInteritemSpacing = 0 // 가로 간격 (셀 사이의 가로 간격, 필요 시 설정)
        
        return layout
        
    }
    
}
