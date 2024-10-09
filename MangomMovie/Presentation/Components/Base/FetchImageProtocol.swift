//
//  FetchImageProtocol.swift
//  MangomMovie
//
//  Created by 박성민 on 10/8/24.
//

import UIKit
import Kingfisher

protocol FetchImageProtocol: AnyObject {
    func fetchImage(imageView: UIImageView, imageURL: String)
}

extension FetchImageProtocol {
    @MainActor func fetchImage(imageView: UIImageView, imageURL: String) {
        guard let url = URL(string: imageURL) else { return }
        imageView.kf.setImage(
        with: url,
        placeholder: nil,
        options: [.transition(.fade(1.2))]
        )
    }
}

