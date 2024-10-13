//
//  CustomAlert.swift
//  MangomMovie
//
//  Created by 박성민 on 10/13/24.
//

import UIKit
import SnapKit
import RxSwift

final class CustomAlert: BaseViewController {
    private let disposeBag = DisposeBag()
    private let alertView = UIView()
    private let titleLabel = UILabel() //제목?
    private let okButton = UIButton() // 확인버튼
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut) { [weak self] in
            self?.alertView.transform = .identity
        }
    }
    override func setUpHierarchy() {
        view.addSubview(alertView)
        alertView.addSubview(titleLabel)
        alertView.addSubview(okButton)
    }
    override func setUpLayout() {
        alertView.snp.makeConstraints { make in
            make.center.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(40)
            make.height.equalTo(100)
        }
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(15)
        }
        okButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(15)
            make.height.equalTo(33)
            make.horizontalEdges.equalToSuperview().inset(30)
        }
    }
    
    override func setUpView() {
        view.backgroundColor = .clear
        self.alertView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        
        alertView.backgroundColor = .asBlack.withAlphaComponent(0.8)
        alertView.layer.cornerRadius = 15
        
        
        titleLabel.font = .boldFont16
        titleLabel.textAlignment = .center
        titleLabel.textColor = .asFont
        
        okButton.setTitle("확인", for: .normal)
        okButton.setTitleColor(.asFont, for: .normal)
        okButton.backgroundColor = .asRed
        okButton.layer.cornerRadius = 5
        okButton.layer.masksToBounds = true
        
        okButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.dismiss(animated: true)
            }.disposed(by: disposeBag)
        
    }
    
}

extension CustomAlert {
    convenience init(titleText: String) {
        self.init()
        self.titleLabel.text = titleText
        self.modalTransitionStyle = .crossDissolve
        self.modalPresentationStyle = .overFullScreen
    }
    
}

