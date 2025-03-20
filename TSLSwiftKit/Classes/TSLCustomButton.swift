//
//  TSLCustomButton.swift
//  TSLSwiftKit
//
//  Created by TSL on 2022/11/24.
//

import UIKit
import SnapKit

// MARK: 支持的样式
public enum TSLCustomButtonIndicator: Int {
    case titleLeft // 文字左 图片右
    case titleRight // 文字右 图片左
    case titleTop // 文字上 图片下
    case titleBottom // 文字下 图片上
}

public class TSLCustomButton: UIButton {
    
    public var buttonTitle: String = ""
    
    public var buttonTitleColor: UIColor = UIColor.black
    
    public var buttonImageName: String = ""
    
    public var buttonIndicatior: TSLCustomButtonIndicator = .titleLeft
    
    // MARK: 图文间距,默认10
    public var graphicDistance: CGFloat = 10.0
      
    // MARK: 图片尺寸
    public var buttonImageWidth: CGFloat = 0.0
    public var buttonImageHeight: CGFloat = 0.0
    
    // MARK: 默认字号
    public var buttonTitleFont: UIFont = kFont(12)
    
    public init(_ frame: CGRect, buttonTitle: String, buttonTitleFont: UIFont, buttonTitleColor: UIColor, buttonImageName: String, target: Any, selector: Selector, buttonIndicatior: TSLCustomButtonIndicator) {
        super.init(frame: frame)
    
        self.buttonTitle = buttonTitle
        
        self.buttonTitleFont = buttonTitleFont
        
        self.buttonTitleColor = buttonTitleColor
        
        self.buttonImageName = buttonImageName
        
        self.buttonIndicatior = buttonIndicatior
        
        self.addTarget(target, action: selector, for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func createSubviews() {
        self.addSubview(self.bottonHoldView)
        
        if self.frame.size.width > 0 {
            self.bottonHoldView.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
        } else {
            self.bottonHoldView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
        
        if self.buttonTitle.count > 0 {
            self.buttonTitleLabel.text = self.buttonTitle
            self.bottonHoldView.addSubview(self.buttonTitleLabel)
        }
         
        if self.buttonImageName.count > 0 {
            self.buttonImageView.image = UIImage(named: self.buttonImageName)
            
            self.bottonHoldView.addSubview(self.buttonImageView)
        }
    }
    
    lazy var bottonHoldView: UIView = {
        var bottonHoldView = TSLUIFactory.view()
        bottonHoldView.isUserInteractionEnabled = false
        bottonHoldView.backgroundColor = kClearColor
        return bottonHoldView
    }()
    
    lazy var buttonTitleLabel: UILabel = {
        var buttonTitleLabel = TSLUIFactory.label(self.buttonTitleFont, textColor: self.buttonTitleColor)
        return buttonTitleLabel
    }()
    
    public lazy var buttonImageView: UIImageView = {
        var buttonImageView = TSLUIFactory.imageView()
        return buttonImageView
    }()
    
    public func refreshView() {
        self.createSubviews()
        
        switch self.buttonIndicatior {
        case .titleLeft:
            self.createCustomButtonIndicatorTitleLeft()
        case .titleTop:
            self.createCustomButtonIndicatorTitleTop()
        case .titleRight:
            self.createCustomButtonIndicatorTitleRight()
        case .titleBottom:
            self.createCustomButtonIndicatorTitleBottom()
        }
    }
    
    // MARK: 文字左,图片右
    func createCustomButtonIndicatorTitleLeft() {
        if self.buttonTitle.count > 0 && self.buttonImageName.count > 0 {
            self.buttonTitleLabel.snp.remakeConstraints { make in
                make.top.left.height.equalToSuperview()
                make.width.equalTo(self.buttonTitleLabel.textWidth())
            }
            
            self.buttonImageView.snp.remakeConstraints { make in
                make.left.equalTo(self.buttonTitleLabel.snp.right).offset(self.graphicDistance)
                make.width.equalTo(self.buttonImageWidth)
                make.height.equalTo(self.buttonImageHeight)
                make.right.centerY.equalToSuperview()
            }
        } else if self.buttonTitle.count > 0 { // 只有文字
            self.buttonTitleLabel.snp.remakeConstraints { make in
                make.edges.equalToSuperview()
                make.width.equalTo(self.buttonTitleLabel.textWidth())
            }
        } else if self.buttonImageName.count > 0 {
            self.buttonImageView.snp.remakeConstraints { make in
                make.width.equalTo(self.buttonImageWidth)
                make.height.equalTo(self.buttonImageHeight)
                make.left.right.centerY.equalToSuperview()
            }
        }
    }
    
    // MARK: 文字右,图片左
    func createCustomButtonIndicatorTitleRight() {
        
    }
    
    // MARK: 文字上,图片下
    func createCustomButtonIndicatorTitleTop() {
        
    }
    
    // MARK: 文字下,图片上
    func createCustomButtonIndicatorTitleBottom() {
        
    }
    
    public var buttonTintColor: UIColor? {
        didSet {
            self.buttonTitleLabel.textColor = buttonTintColor
            
            self.buttonImageView.image = UIImage(named: self.buttonImageName)?.withRenderingMode(.alwaysTemplate)
            self.buttonImageView.tintColor = buttonTintColor
        }
    }
    
}
