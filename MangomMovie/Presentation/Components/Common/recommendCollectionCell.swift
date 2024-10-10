//
//  recommendCollectionCell.swift
//  MangomMovie
//
//  Created by 박성민 on 10/10/24.
//

import UIKit
import SnapKit
import RxSwift

final class recommendCollectionCell: BaseCollectioViewCell {
    private let poster = UIImageView()
    private let title = UILabel()
    private let playButton = UIImageView()
    
    override func setUpHierarchy() {
        self.addSubview(poster)
        self.addSubview(title)
        self.addSubview(playButton)
    }
    
    override func setUpLayout() {
        poster.snp.makeConstraints { make in
            make.leading.verticalEdges.equalToSuperview()
            make.width.equalTo(self.frame.width / 3)
        }
        title.snp.makeConstraints { make in
            make.leading.equalTo(poster.snp.trailing).offset(10)
            make.centerY.equalToSuperview()
        }
        playButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
            make.size.equalTo(40)
        }
    }
    
    override func setUpView() {
        poster.image = UIImage.test
        poster.contentMode = .scaleAspectFill
        poster.layer.masksToBounds = true
        
        title.textColor = .asFont
        title.font = .font14
        title.textAlignment = .left
        title.numberOfLines = 1
        title.text = "인사이드 아웃 2"
        
        playButton.image = UIImage.asPlayCircle
        playButton.tintColor = .asWhite
        playButton.contentMode = .scaleToFill
    }
}
