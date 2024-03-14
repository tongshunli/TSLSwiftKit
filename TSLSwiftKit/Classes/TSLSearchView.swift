//
//  TSLSearchView.swift
//  TSLSwiftKit
//
//  Created by TSL on 2023/4/25.
//  搜索

import UIKit

public class TSLSearchView: UIView {

    public var searchConfirmBlock: ((_ searchWord: String) -> Void) = {_ in }
        
    var searchBarCleanText: () -> Void = {}
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.createSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func createSubviews() {
        self.backgroundColor = kColorRGB(249, green: 249, blue: 249)
        
        self.addSubview(self.searchImageView)
        
        self.searchImageView.snp.makeConstraints { make in
            make.right.equalTo(-kHalfMargin)
            make.width.height.equalTo(18)
            make.centerY.equalToSuperview()
        }
        
        self.addSubview(self.searchTextField)
        
        self.searchTextField.snp.makeConstraints { make in
            make.left.equalTo(kHalfMargin)
            make.right.equalTo(-kHalfMargin)
            make.top.bottom.equalToSuperview()
        }
    }
    
    public lazy var searchImageView: UIImageView = {
        var searchImageView = TSLUIFactory.imageView()
        searchImageView.image = Bundle.getBundleImageWithName("search")
        return searchImageView
    }()
    
    public lazy var searchTextField: UITextField = {
        var searchTextField = TSLUIFactory.textField(kFont(16), textColor: UIColor.black, placeholder: "")
        searchTextField.backgroundColor = kClearColor
        searchTextField.clearButtonMode = .whileEditing
        searchTextField.delegate = self
        searchTextField.returnKeyType = .search
        searchTextField.addTarget(self, action: #selector(changeText), for: .editingChanged)
        
        let rightImageView = TSLUIFactory.imageView()
        rightImageView.frame = CGRect(x: 0, y: 0, width: 18.0, height: 18.0)
        rightImageView.image = Bundle.getBundleImageWithName("search")?.withRenderingMode(.alwaysTemplate)
        rightImageView.tintColor = kColorRGB(156, green: 155, blue: 157)
        
        let rightView = TSLUIFactory.view()
        rightView.frame = CGRect(x: 0, y: 0, width: 30, height: self.frame.size.height)
        rightView.backgroundColor = kClearColor
        rightView.addSubview(rightImageView)
        
        rightImageView.center = rightView.center
        
        searchTextField.rightViewMode = .always
        searchTextField.rightView = rightView
        return searchTextField
    }()
    
    @objc func changeText() {
        if self.searchTextField.text == "" {
            self.searchBarCleanText()
        }
     }
    
    public var placeholderText: String? {

        didSet {
            let attrString = NSAttributedString.init(string: placeholderText ?? "", attributes: [NSAttributedString.Key.foregroundColor: kColorRGB(156, green: 155, blue: 157), NSAttributedString.Key.font: kFont(16)])

            self.searchTextField.attributedPlaceholder = attrString
        }
    }

    var searchText: String? {
        didSet {
            self.searchTextField.text = searchText ?? ""
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension TSLSearchView: UITextFieldDelegate {
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == "\n" {
            if textField.text?.count ?? 0 > 0 {
                self.searchConfirmBlock(searchTextField.text ?? "")
            } else if self.placeholderText?.count ?? 0 > 0 {
                self.searchConfirmBlock(self.placeholderText ?? "")
            }
            
            textField.resignFirstResponder()
            
            return false
        }
        
        return true
    }
    
}
