//
//  TSL_UIFactory.swift
//  TSLLibrary
//
//  Created by TSL on 2021/9/2.
//  UI封装

import UIKit

public class TSLUIFactory: UIView {

    /// 初始化UIView
    public class func view() -> UIView {
        let view = UIView.init()
        view.clipsToBounds = true
        view.backgroundColor = kClearColor
        return view
    }

    /// 初始化UILabel
    public class func label(_ textFont: UIFont, textColor: UIColor?) -> UILabel {
        let label = UILabel.init()
        label.font = textFont
        label.layer.masksToBounds = true
        label.textColor = textColor ?? UIColor.black
        return label
    }

    /// 初始化UIImageView
    public class func imageView() -> UIImageView {
        let imageView = UIImageView.init()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        return imageView
    }

    /// 初始化UIButton
    public class func button(_ target: Any, selector: Selector) -> UIButton {
        let button = UIButton(type: .custom)
        button.addTarget(target, action: selector, for: .touchUpInside)
        button.clipsToBounds = true
        button.adjustsImageWhenHighlighted = false
        button.backgroundColor = kClearColor
        return button
    }

    /// 初始化UIButton
    public class func button(_ imageName: String, edgeInsets: UIEdgeInsets, target: Any, selector: Selector) -> UIButton {
        return self.button(imageName, imageModel: .automatic, edgeInsets: edgeInsets, target: target, selector: selector)
    }
    
    /// 初始化UIButton
    public class func button(_ imageName: String, imageModel: UIImage.RenderingMode, edgeInsets: UIEdgeInsets, target: Any, selector: Selector) -> UIButton {
        let button = self.button(target, selector: selector)
        button.setImage(UIImage(named: imageName)?.withRenderingMode(imageModel), for: .normal)
        button.imageEdgeInsets = edgeInsets
        return button
    }

    /// 初始化UIButton
    public class func button(_ textFont: UIFont, textColor: UIColor, target: Any, selector: Selector) -> UIButton {
        let button = self.button(target, selector: selector)
        button.titleLabel?.font = textFont
        button.setTitleColor(textColor, for: .normal)
        return button
    }

    /// 初始化UITextField
    public class func textField(_ textFont: UIFont, textColor: UIColor, placeholder: String) -> UITextField {
        let textField = UITextField.init()
        textField.font = textFont
        textField.textColor = textColor
        textField.placeholder = placeholder
        textField.clearButtonMode = .whileEditing
        return textField
    }

    /// 初始化UIScrollVIew
    public class func scrollView() -> UIScrollView {
        let scrollView = UIScrollView.init()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = kClearColor
        return scrollView
    }

    /// 初始化UITextView
    public class func textView(_ textFont: UIFont, textColor: UIColor) -> UITextView {
        let textView = UITextView.init()
        textView.font = textFont
        textView.textColor = textColor
        textView.showsVerticalScrollIndicator = false
        textView.showsHorizontalScrollIndicator = false
        return textView
    }

    /// 初始化UITableView
    public class func tableView(_ style: UITableView.Style) -> UITableView {
        let tableView = UITableView.init(frame: CGRect.zero, style: style)
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.estimatedRowHeight = 44.0
        tableView.sectionFooterHeight = 10.0
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        tableView.backgroundColor = kClearColor
        return tableView
    }

    /// 初始化UICollectionView
    public class func collectionView(_ flyout: UICollectionViewFlowLayout) -> UICollectionView {
        let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flyout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.backgroundColor = kClearColor
        return collectionView
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
