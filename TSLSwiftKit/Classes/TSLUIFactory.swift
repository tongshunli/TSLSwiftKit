//
//  TSL_UIFactory.swift
//  TSLLibrary
//
//  Created by TSL on 2021/9/2.
//

import UIKit

public class TSLUIFactory: UIView {

    public class func view() -> UIView {
        let view = UIView.init()
        view.clipsToBounds = true
        return view
    }
    
    public class func label(_ textFont: UIFont, textColor: UIColor) -> UILabel {
        let label = UILabel.init()
        label.font = textFont
        label.textColor = textColor
        return label
    }
    
    public class func imageView() -> UIImageView {
        let imageView = UIImageView.init()
        imageView.clipsToBounds = true
        return imageView
    }
    
    public class func button(_ target: Any, selector: Selector) -> UIButton {
        let button = UIButton.init(type: .custom)
        button.addTarget(target, action: selector, for: .touchUpInside)
        button.clipsToBounds = true
        button.adjustsImageWhenHighlighted = false
        return button
    }
    
    public class func button(_ textFont: UIFont, textColor: UIColor, target: Any, selector: Selector) -> UIButton {
        let button = button(target, selector: selector)
        button.titleLabel?.font = textFont
        button.setTitleColor(textColor, for: .normal)
        return button
    }
    
    public class func textField(_ textFont: UIFont, textColor: UIColor, placeholder: String) -> UITextField {
        let textField = UITextField.init()
        textField.font = textFont;
        textField.textColor = textColor
        textField.placeholder = placeholder
        textField.clearButtonMode = .whileEditing
        return textField
    }
    
    public class func scrollView() -> UIScrollView {
        let scrollView = UIScrollView.init()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }
    
    public class func textView(_ textFont: UIFont, textColor: UIColor) -> UITextView {
        let textView = UITextView.init()
        textView.font = textFont
        textView.textColor = textColor
        textView.showsVerticalScrollIndicator = false
        textView.showsHorizontalScrollIndicator = false
        return textView
    }
    
    public class func tableView(_ style: UITableView.Style) -> UITableView {
        let tableView = UITableView.init(frame: CGRect.zero, style: style)
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.contentInsetAdjustmentBehavior = .never
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        return tableView
    }
    
    public class func collectionView(_ flyout: UICollectionViewLayout) -> UICollectionView {
        let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flyout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInsetAdjustmentBehavior = .never
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
