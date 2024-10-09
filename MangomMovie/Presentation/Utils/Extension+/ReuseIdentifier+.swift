//
//  ReuseIdentifier+.swift
//  MangomMovie
//
//  Created by 박성민 on 10/8/24.
//

import Foundation

protocol ReuseIdentifier: AnyObject {
    static var id: String { get }
}

extension ReuseIdentifier {
    static var id: String {
        return String(describing: self)
    }
}

extension NSObject: ReuseIdentifier { }
