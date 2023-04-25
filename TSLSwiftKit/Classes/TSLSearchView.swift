//
//  TSLSearchView.swift
//  TSLSwiftKit
//
//  Created by TSL on 2023/4/25.
//  搜索

import UIKit

class TSLSearchView: UIView {

    var searchButtonClickedWithSearchTextBlock: (_ searchTextFieldText: String) -> Void = {searchTextFieldText in }
        
    var searchBarCleanText: () -> Void = {}
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.createSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func createSubviews() {
        self.backgroundColor = UIColor.clear
        
        self.addSubview(self.searchTextField)
        
        self.searchTextField.snp.makeConstraints { make in
            make.left.equalTo(kHalfMargin)
            make.right.equalTo(-kHalfMargin)
            make.centerY.equalToSuperview()
            make.height.equalTo(36)
        }
    }
    
    public lazy var searchTextField: UITextField = {
        var searchTextField = TSLUIFactory.textField(kFont(16), textColor: UIColor.black, placeholder: "")
        searchTextField.backgroundColor = kColorRGB(237, g: 238, b: 238)
        searchTextField.clearButtonMode = .whileEditing
        searchTextField.delegate = self
        searchTextField.returnKeyType = .search
        searchTextField.addTarget(self, action: #selector(changeText), for: .editingChanged)
        searchTextField.layer.cornerRadius = 18
        
        let leftImageView = TSLUIFactory.imageView()
        leftImageView.frame = CGRect(x: 0, y: 0, width: 18.0, height: 18.0)
        leftImageView.image = UIImage.init(named: "public_search")?.withRenderingMode(.alwaysTemplate)
        leftImageView.tintColor = kColorRGB(156, g: 155, b: 157)
        
        let leftView = TSLUIFactory.view()
        leftView.frame = CGRect(x: 0, y: 0, width: 30, height: 44)
        leftView.backgroundColor = kClearColor
        leftView.addSubview(leftImageView)
        
        leftImageView.center = leftView.center
        
        searchTextField.leftViewMode = .always
        searchTextField.leftView = leftView
        return searchTextField
    }()
    
    @objc func changeText() {
        if self.searchTextField.text == "" {
            self.searchBarCleanText()
        }
     }
    
    public var placeholderText: String? {

        didSet {
            let attrString = NSAttributedString.init(string: placeholderText ?? "", attributes: [NSAttributedString.Key.foregroundColor: kColorRGB(156, g: 155, b: 157), NSAttributedString.Key.font: kFont(16)])

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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == "\n" {
            if textField.text?.count ?? 0 > 0 {
                self.searchButtonClickedWithSearchTextBlock(searchTextField.text ?? "")
            } else if self.placeholderText?.count ?? 0 > 0 {
                self.searchButtonClickedWithSearchTextBlock(self.placeholderText ?? "")
            }
            
            textField.resignFirstResponder()
            
            return false
        }
        
        return true
    }
    
}
