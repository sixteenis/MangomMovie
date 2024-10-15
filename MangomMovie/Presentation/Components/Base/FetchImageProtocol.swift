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
        guard let url = URL(string: APIKey.baseURL + imageURL) else { return }
        imageView.kf.setImage(
        with: url,
        placeholder: nil,
        options: [.transition(.fade(1.2))]
        )
    }
    @MainActor func fetchImage(imageView: UIImageView, realmURL: String) {
        imageView.image = self.loadImageToDocument(filename: realmURL)
    }
}
private extension FetchImageProtocol {
    func loadImageToDocument(filename: String) -> UIImage? {
        guard let document = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        ).first else { return nil}
        
        let fileURL = document.appendingPathComponent("\(filename).jpg")
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            return UIImage(contentsOfFile: fileURL.path)
        } else {
            
            return UIImage(systemName: "star.fill")
        }
    }
}

