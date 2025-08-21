//
//  TSLCustomButton.swift
//  TSLSwiftKit
//
//  Created by TSL on 2022/11/24.
//

import UIKit
import SnapKit

/// 支持的样式
public enum TSLCustomButtonIndicator: Int {
    /// 文字左 图片右
    case titleLeft
    /// 文字右 图片左
    case titleRight
    /// 文字上 图片下
    case titleTop
    /// 文字下 图片上
    case titleBottom
}

public class TSLCustomButton: UIButton {
    public var buttonTitleColor: UIColor = UIColor.black
    public var buttonIndicatior: TSLCustomButtonIndicator = .titleLeft
    /// 图文间距,默认10
    public var graphicDistance: CGFloat = 10.0
    /// 图片尺寸
    public var buttonImageWidth: CGFloat = 0.0
    public var buttonImageHeight: CGFloat = 0.0
    /// 默认字号
    public var buttonTitleFont: UIFont = kFont(12)
    /// 图片展示模式
    var imageModel: UIImage.RenderingMode = .automatic
    /// 动画开启状态
    var needsRemoved: Bool = false

    public init(_ buttonTitle: String, buttonTitleFont: UIFont, buttonTitleColor: UIColor, buttonImageName: String, imageModel: UIImage.RenderingMode, target: Any, selector: Selector, buttonIndicatior: TSLCustomButtonIndicator) {
        super.init(frame: CGRect.zero)
        self.buttonTitle = buttonTitle
        self.buttonTitleFont = buttonTitleFont
        self.buttonTitleColor = buttonTitleColor
        self.buttonImageName = buttonImageName
        self.imageModel = imageModel
        self.buttonIndicatior = buttonIndicatior
        self.addTarget(target, action: selector, for: .touchUpInside)
    }
    
    public init(_ buttonTitle: String, buttonTitleFont: UIFont, buttonTitleColor: UIColor, buttonImageName: String, target: Any, selector: Selector, buttonIndicatior: TSLCustomButtonIndicator) {
        super.init(frame: CGRect.zero)
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
            self.buttonImageView.image = UIImage(named: self.buttonImageName)?.withRenderingMode(self.imageModel)
            self.bottonHoldView.addSubview(self.buttonImageView)
        }
    }

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

    /// 文字左,图片右
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

    /// 文字右,图片左
    func createCustomButtonIndicatorTitleRight() {
        if self.buttonTitle.count > 0 && self.buttonImageName.count > 0 {
            self.buttonTitleLabel.snp.remakeConstraints { make in
                make.top.right.height.equalToSuperview()
                make.width.equalTo(self.buttonTitleLabel.textWidth())
            }
            self.buttonImageView.snp.remakeConstraints { make in
                make.right.equalTo(self.buttonTitleLabel.snp.left).offset(-self.graphicDistance)
                make.width.equalTo(self.buttonImageWidth)
                make.height.equalTo(self.buttonImageHeight)
                make.left.centerY.equalToSuperview()
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

    /// 文字上,图片下
    func createCustomButtonIndicatorTitleTop() {
    }

    /// 文字下,图片上
    func createCustomButtonIndicatorTitleBottom() {
    }

    public var buttonTintColor: UIColor? {
        didSet {
            self.buttonTitleLabel.textColor = buttonTintColor
            self.buttonImageView.image = UIImage(named: self.buttonImageName)?.withRenderingMode(.alwaysTemplate)
            self.buttonImageView.tintColor = buttonTintColor
        }
    }
    
    /// 开启动画
    public func startSpin() {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.fromValue = 0.0
        animation.toValue = .pi * 2.0
        animation.duration = 0.8
        animation.autoreverses = false
        animation.fillMode = .forwards
        animation.repeatCount = MAXFLOAT
        self.buttonImageView.layer.add(animation, forKey: "spin")
        self.needsRemoved = false
        Timer.scheduledTimer(withTimeInterval: animation.duration, repeats: true, block: { [unowned self] timer in
            if self.needsRemoved {
                self.buttonImageView.layer.removeAnimation(forKey: "spin")
                self.needsRemoved = false
                timer.invalidate()
            }
        })
    }
    
    /// 停止动画
    public func stopSpin() {
        self.needsRemoved = true
    }
    
    public var buttonImageName: String = "" {
        didSet {
            self.buttonImageView.image = UIImage(named: buttonImageName)?.withRenderingMode(self.imageModel)
        }
    }

    public var buttonTitle: String = "" {
        didSet {
            self.buttonTitleLabel.text = buttonTitle
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
}
