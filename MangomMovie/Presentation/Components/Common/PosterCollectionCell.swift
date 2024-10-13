//
//  PosterCollectionCell.swift
//  MangomMovie
//
//  Created by 박성민 on 10/10/24.
//

import UIKit
import SnapKit
import RxSwift

final class PosterCollectionCell: BaseCollectioViewCell {
    private var disposeBag = DisposeBag()
    private let poster = UIImageView()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    override func setUpHierarchy() {
        self.addSubview(poster)
    }
    
    override func setUpLayout() {
        poster.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func setUpView() {
        poster.layer.cornerRadius = 15
        poster.layer.masksToBounds = true
    }
    
    func setUpData(data: CompactMedia) {
        print(data.imagePath)
        self.fetchImage(imageView: self.poster, imageURL: data.imagePath)
    }
}
