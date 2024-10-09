//
//  BaseCollectioViewCell.swift
//  MangomMovie
//
//  Created by 박성민 on 10/8/24.
//

import UIKit

class BaseCollectioViewCell: UICollectionViewCell, FetchImageProtocol {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .asBackground
        setUpHierarchy()
        setUpLayout()
        setUpView()
    }
    
    func setUpHierarchy() {}
    func setUpLayout() {}
    func setUpView() {}
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
