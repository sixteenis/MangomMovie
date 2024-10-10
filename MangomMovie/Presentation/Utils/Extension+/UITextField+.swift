//
//  UITextField+.swift
//  MangomMovie
//
//  Created by 박성민 on 10/10/24.
//

import UIKit
// MARK: - 텍스트필드 왼쪽 패딩주기
extension UITextField {
    func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
      }
}
