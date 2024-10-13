//
//  AlertType.swift
//  MangomMovie
//
//  Created by 박성민 on 10/13/24.
//

import Foundation

@frozen
enum AlertType {
    case save
    case alreadySave
    
    var title: String {
        switch self {
        case .save:
            return "미디어를 저장했어요 :)"
        case .alreadySave:
            return "이미 저장된 미디어에요 :)"
        }
    }
}
