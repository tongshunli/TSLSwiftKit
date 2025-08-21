//
//  DVTextView.swift
//  MyEngineeringCollection
//
//  Created by 佟顺利 on 2025/7/25.
//

import UIKit

public class TSLTextView: UIView {

    /// 最大行数 默认为无穷大
    public var maxLine: CGFloat = CGFLOAT_MAX
    
    /// 高度变化回调
    var textHeightChangeBlock: (_ height: CGFloat) -> Void = { _ in }
    
    /// 点击发送按钮
    var returnHandlerBlock: () -> Void = { }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    /// 占位文字
    public var placeholder: String? {
        didSet {
            
        }
    }
    
    /// 最大字数
    public var maxLength: Int? {
        didSet {
            
        }
    }
    
    /// 竖直方向上下间距 默认为8
    public var vMargin: CGFloat? {
        didSet {
            
        }
    }
    
    /// 默认为17
    public var font: UIFont? {
        didSet {
            
        }
    }
    
    public var text: String? {
        get {
            return self.textView.text
        }
        set {
            self.textView.text = newValue
        }
    }
    
    public lazy var textView = {
        let textView = TSLCustomTextView()
        return textView
    }()
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
