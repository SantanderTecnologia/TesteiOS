//
//  CustomTextField.swift
//  Santander
//
//  Created by Gabriel vieira on 4/22/18.
//  Copyright © 2018 Gabriel vieira. All rights reserved.
//

import UIKit

enum FieldType: Int {
    case field = 1
    case text = 2
    case image = 3
    case checkbox = 4
    case send = 5
}

enum TextFieldType: Int {
    case unknown = 0
    case text = 1
    case telNumber = 2
    case email = 3
}

class CustomTextField: UIView {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: JMMaskTextField!
    @IBOutlet weak var statusBar: UIView!
    @IBOutlet weak var clearButton: UIButton!
    var fieldIsValid: Bool = false
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    fileprivate func setupView() {
        let view = viewFromNibForClass()
        view.frame = bounds
        view.autoresizingMask = [
            UIViewAutoresizing.flexibleWidth,
            UIViewAutoresizing.flexibleHeight
        ]
        addSubview(view)
        self.config()
    }
    
    fileprivate func viewFromNibForClass() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "CustomTextField", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    func config() {
        self.textField.delegate = self
        self.textField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        self.textField.returnKeyType = .done
        self.hideClearButton(true)
        self.textField.autocorrectionType = .no
    }
    
    func setLabelText(text: String) {
        self.label.text = text
    }
    
    @IBAction func clearClick(_ sender: Any) {
        
        if self.textField.isEditing {
            self.textField.text = ""
        } else {
            self.textField.text = ""
            self.animateLabel(state: false)
        }
        
        self.hideClearButton(true)
    }
    
    func hideClearButton(_ hide: Bool) {
        self.clearButton.isHidden = hide
    }
    
    func validateField() {
        self.fieldIsValid = true
        
        if self.textField.text == "" {
            self.setStatusBarColor(Color.gray)
        } else {
            self.setStatusBarColor(Color.riskLightGreen)
        }
        
        
    }
    
    func setStatusBarColor(_ color: UIColor) {
        self.statusBar.backgroundColor = color
    }
    
    private func animateLabel(state: Bool) {
        var frame = self.label.frame
        
        if state {
            frame.origin.y = 0
            UIView.animate(withDuration: 0.1) {
                self.label.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                self.label.frame = frame
            }
        } else {
            frame.origin.y = 30
            UIView.animate(withDuration: 0.1) {
                self.label.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                self.label.frame = frame
            }
        }
    }
    
    
}

extension CustomTextField: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.animateLabel(state: true)
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text == "" {
            self.animateLabel(state: false)
        }
        
        return true
    }
    
    @objc func textFieldDidChange(textField: UITextField){
        if textField.text == "" {
           self.hideClearButton(true)
        } else {
            self.hideClearButton(false)
        }
        
        self.validateField()
    }
}


