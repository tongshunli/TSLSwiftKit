//
//  TSLCustomButton.swift
//  TSLSwiftKit
//
//  Created by TSL on 2022/11/24.
//

import UIKit
import SnapKit

//  支持的样式
public enum TSLCustomButtonIndicator: Int {
    case titleLeft = 0 // 文字左 图片右
    case titleRight = 1 // 文字右 图片左
    case titleTop = 2 // 文字上 图片下
    case titleBottom = 3 // 文字下 图片上
}

public class TSLCustomButton: UIButton {
    
    var buttonTitle: String = ""
    
    var buttonImageName: String = ""
    
    var placeholderImage: UIImage?
    
    var buttonIndicatior: TSLCustomButtonIndicator = .titleLeft
    
    //  图文间距,默认10
    public var graphicDistance: CGFloat = 10.0
    
    //  边距,默认0
    var buttonMargin: CGFloat = 0.0
    
    //  图片尺寸
    public var buttonImageWidth: CGFloat = 0.0
    public var buttonImageHeight: CGFloat = 0.0
    
    //  默认字号
    var buttonTitleFont: UIFont = kFont(12)
    
    public init(_ frame: CGRect, buttonTitle: String, buttonTitleFont: UIFont, buttonImageName: String, placeholderImage: UIImage?, buttonIndicatior: TSLCustomButtonIndicator) {
        super.init(frame: frame)
    
        self.buttonTitle = buttonTitle
        
        self.buttonTitleFont = buttonTitleFont
        
        self.buttonImageName = buttonImageName
        
        self.placeholderImage = placeholderImage
        
        self.buttonIndicatior = buttonIndicatior
        
        self.createSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func createSubviews() {
        self.addSubview(self.bottonHoldView)
        
        self.bottonHoldView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        if self.buttonTitle.count > 0 {
            self.buttonTitleLabel.text = self.buttonTitle
            self.bottonHoldView.addSubview(self.buttonTitleLabel)
        }
         
        if self.buttonImageName.count > 0 {
            self.buttonImageView.image = UIImage(named: self.buttonImageName)?.withRenderingMode(.automatic)
            
            self.bottonHoldView.addSubview(self.buttonImageView)
        }
    }
    
    lazy var bottonHoldView: UIView = {
        var bottonHoldView = TSLUIFactory.view()
        bottonHoldView.isUserInteractionEnabled = false
        return bottonHoldView
    }()
    
    lazy var buttonTitleLabel: UILabel = {
        var buttonTitleLabel = TSLUIFactory.label(self.buttonTitleFont, textColor: UIColor.black)
        return buttonTitleLabel
    }()
    
    lazy var buttonImageView: UIImageView = {
        var buttonImageView = TSLUIFactory.imageView()
        return buttonImageView
    }()
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        self.refreshView()
    }
    
    func refreshView() {
        switch self.buttonIndicatior {
        case .titleLeft:
            self.createCustomButtonIndicatorTitleLeft()
            break
        case .titleTop:
            self.createCustomButtonIndicatorTitleTop()
            break
        case .titleRight:
            self.createCustomButtonIndicatorTitleRight()
            break
        case .titleBottom:
            self.createCustomButtonIndicatorTitleBottom()
            break
        }
    }
    
    //  文字左,图片右
    func createCustomButtonIndicatorTitleLeft() {
        if self.buttonTitle.count > 0 && self.buttonImageName.count > 0 {
            self.buttonTitleLabel.snp.makeConstraints { make in
                make.left.equalTo(self.buttonMargin)
                make.top.height.equalToSuperview()
            }
            
            self.buttonImageView.snp.makeConstraints { make in
                make.left.equalTo(self.buttonTitleLabel.snp.right).offset(self.graphicDistance)
                make.width.equalTo(self.buttonImageWidth)
                make.height.equalTo(self.buttonImageHeight)
                make.right.equalTo(-self.buttonMargin)
                make.centerY.equalToSuperview()
            }
        } else if self.buttonTitle.count > 0 { // 只有文字
            self.buttonTitleLabel.snp.makeConstraints { make in
                make.left.equalTo(self.buttonMargin)
                make.right.equalTo(-self.buttonMargin)
                make.top.bottom.equalToSuperview()
            }
        } else if self.buttonImageName.count > 0 {
            self.buttonImageView.snp.makeConstraints { make in
                make.left.equalTo(self.buttonMargin)
                make.right.equalTo(-self.buttonMargin)
                make.width.equalTo(self.buttonImageWidth)
                make.height.equalTo(self.buttonImageHeight)
                make.centerY.equalToSuperview()
            }
        }
    }
    
    //  文字右,图片左
    func createCustomButtonIndicatorTitleRight() {
        
    }
    
    //  文字上,图片下
    func createCustomButtonIndicatorTitleTop() {
        
    }
    
    //  文字下,图片上
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
