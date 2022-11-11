//
//  TSLTopAlertView.swift
//  TSLSwiftKit
//
//  Created by TSL on 2022/11/11.
//  提示弹框

import UIKit

public enum AlertType: Int {
    case success = 0
    case error = 1
}

public class TSLTopAlertView: UIView {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.isUserInteractionEnabled = true
        
        self.backgroundColor = kClearColor
        
        self.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
        kWindow?.addSubview(self)
        
        self.createSubviews()
        
        let recognizer = UISwipeGestureRecognizer.init(target: self, action: #selector(recognizerHandle))
        recognizer.direction = .up
        self.addGestureRecognizer(recognizer)
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func createSubviews() {
        self.addSubview(self.alertBottonView)
        
        self.alertBottonView.addSubview(self.alertImageView)
        
        self.alertBottonView.addSubview(self.alertTitleLabel)
    }
    
    lazy var alertTitleLabel: UILabel = {
        var alertTitleLabel = TSLUIFactory.label(kFont(14), textColor: UIColor.black)
        alertTitleLabel.frame = CGRect(x: 50, y: kNavbarHeight - 45, width: kScreenWidth - 60, height: 30)

        return alertTitleLabel
    }()
    
    lazy var alertImageView: UIImageView = {
        var alertImageView = TSLUIFactory.imageView()
        alertImageView.frame = CGRectMake(kMargin, kNavbarHeight - 40, kMargin, kMargin)
        return alertImageView
    }()
    
    @objc func recognizerHandle(_ recognizer: UISwipeGestureRecognizer) {
        if recognizer.direction == .up {
            self.hiddenAlertView()
        }
    }
    
    func hiddenAlertView() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: kAnimatedDuration, delay: 1, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: .showHideTransitionViews) { [unowned self] in
                self.alertBottonView.frame = CGRect(x: 0, y: -kNavbarHeight, width: kScreenWidth, height: kNavbarHeight)
            } completion: {[unowned self] finish in
                self.removeAlertView()
            }
        }
    }
    
    lazy var alertBottonView: UIView = {
        var alertBottonView = TSLUIFactory.view()
        alertBottonView.backgroundColor = kWhiteColor
        alertBottonView.frame = CGRect(x: 0, y: -kNavbarHeight, width: kScreenWidth, height: kNavbarHeight)
        return alertBottonView
    }()
    
    func removeAlertView() {
        self.removeAlertView()
        self.removeFromSuperview()
    }
    
    // 提示语
    var alertTitle: String? {
        didSet {
            self.alertTitleLabel.text = alertTitle
        }
    }
    
    //  成功或失败
    var alertType: AlertType? {
        didSet {
            if alertType == .success {
                self.alertImageView.image = UIImage.init(named: "tips_success")
            }
            
            if alertType == .error {
                self.alertImageView.image = UIImage.init(named: "tips_error")
            }
        }
    }
    
    func showAlertView() {
        
        UIView.animate(withDuration: kAnimatedDuration, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0) { [unowned self] in
            self.alertBottonView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kNavbarHeight)
        } completion: { finish in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: { [unowned self] in
                self.hiddenAlertView()
            })
        }
    }
    
    public override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        
        let hitView = super.hitTest(point, with: event)
        
        if hitView == self {
            return nil
        }
        
        return hitView
    }
    
}
