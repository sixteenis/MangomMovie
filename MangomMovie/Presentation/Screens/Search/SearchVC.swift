//
//  SearchVC.swift
//  MangomMovie
//
//  Created by 박성민 on 10/8/24.
//

import UIKit
import RxSwift
import RxCocoa

import SnapKit

final class SearchVC: BaseViewController {
    private let disposeBag = DisposeBag()
    private let vm: SearchVM = SearchVM()
    
    private let searchView = UITextField()
    
    private let genreLabel = UILabel()
    private lazy var recommendCollection = UICollectionView(frame: .zero, collectionViewLayout: self.recommendColletionLayout())
    private lazy var searchCollection = UICollectionView(frame: .zero, collectionViewLayout: self.searchColletionLayout())
    
    private let testArr = Observable.just([1,2,3,4,5,6,7,8,9,10])
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func bindData() {
        let input = SearchVM.Input(viewDidLoad: Observable.just(()), searchText: searchView.rx.text.orEmpty)
        let output = vm.transform(input: input)
        output.nowState
            .bind(with: self) { owner, state in
                owner.setUpCollectionView(type: state)
            }.disposed(by: disposeBag)
        output.trendMovieList
            .bind(to: recommendCollection.rx.items(cellIdentifier: recommendCollectionCell.id, cellType: recommendCollectionCell.self)) { (row, element, cell) in
                cell.setUpData(element)
            }.disposed(by: disposeBag)
        
        output.searchMovieList
            .bind(to: searchCollection.rx.items(cellIdentifier: PosterCollectionCell.id, cellType: PosterCollectionCell.self)) { (row, element, cell) in
                cell.setUpData(data: element)
            }.disposed(by: disposeBag)
        
        recommendCollection.rx.modelSelected(CompactMedia.self)
            .bind(with: self) { owner, data in
                self.presentDetatilView(model: data)
            }.disposed(by: disposeBag)
        
        searchCollection.rx.modelSelected(CompactMedia.self)
            .bind(with: self) { owner, data in
                self.presentDetatilView(model: data)
            }.disposed(by: disposeBag)
        
    }
    // MARK: - 연결 부분
    override func setUpHierarchy() {
        view.addSubview(searchView)
        view.addSubview(genreLabel)
        view.addSubview(recommendCollection)
        view.addSubview(searchCollection)
    }
    // MARK: - 레이아웃 부분
    override func setUpLayout() {
        searchView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(33)
        }
        genreLabel.snp.makeConstraints { make in
            make.top.equalTo(searchView.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        recommendCollection.snp.makeConstraints { make in
            make.top.equalTo(genreLabel.snp.bottom).offset(20)
            make.horizontalEdges.bottom.equalToSuperview()
        }
        searchCollection.snp.makeConstraints { make in
            make.edges.equalTo(recommendCollection)
        }
        
    }
    // MARK: - 데이터 부분
    override func setUpView() {
        searchView.backgroundColor = .asDarkBlack
        searchView.placeholder = "게임,시리즈,영화를 검색하세요..."
        searchView.textColor = .asPlaceholder
        searchView.layer.cornerRadius = 15
        searchView.addLeftPadding()
        
        genreLabel.text = "추천 시리즈 & 영화"
        genreLabel.font = .boldFont16
        genreLabel.textColor = .asFont
        
        recommendCollection.backgroundColor = .asBackground
        recommendCollection.register(recommendCollectionCell.self, forCellWithReuseIdentifier: recommendCollectionCell.id)
        recommendCollection.showsVerticalScrollIndicator = false
        
        searchCollection.backgroundColor = .asBackground
        searchCollection.register(PosterCollectionCell.self, forCellWithReuseIdentifier: PosterCollectionCell.id)
        searchCollection.showsVerticalScrollIndicator = false
    }
}
// MARK: - 컬렉션 뷰 타입 선택 함수 부분
private extension SearchVC {
    func setUpCollectionView(type: CollectionType) {
        genreLabel.text = type.genreLabelTilte
        if type == .recommend {
            searchCollection.isHidden = true
            recommendCollection.isHidden = false
        } else {
            searchCollection.isHidden = false
            recommendCollection.isHidden = true
        }
    }
}
// MARK: - 컬렉션 뷰 레이아웃 부분
private extension SearchVC {
    func recommendColletionLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height / 8
        
        layout.itemSize = CGSize(width: width, height: height)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 15, left: 10, bottom: 10, right: 10)
        layout.minimumLineSpacing = 30 // 세로 간격 (셀 간의 줄 간격)
        return layout
        
    }
    func searchColletionLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width / 3 - 5
        let height = UIScreen.main.bounds.height / 4
        
        layout.itemSize = CGSize(width: width, height: height)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 15, left: 0, bottom: 10, right: 0)
        
        layout.minimumLineSpacing = 5 // 세로 간격 (셀 간의 줄 간격)
        layout.minimumInteritemSpacing = 0 // 가로 간격 (셀 사이의 가로 간격, 필요 시 설정)
        
        return layout
        
    }

}
