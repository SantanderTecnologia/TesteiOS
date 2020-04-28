//
//  CustomTextField.swift
//  Teste Santander
//
//  Created by Eduardo Alves Sumiya on 27/04/20.
//  Copyright © 2020 Eduardo Alves Sumiya. All rights reserved.
//

import Foundation
import UIKit

protocol CustomTextFieldProtocol {
    
}

@IBDesignable
class CustomTextField: UIView, UITextFieldDelegate {
    // MARK: - Properties
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var lblPlaceholder: UILabel!
    @IBOutlet weak var txtInput: UITextField!
    @IBOutlet weak var btnClearInput: UIButton!
    @IBOutlet weak var viewValidationStatus: UIView!
    
    // MARK: - Inspectable Variables
    @IBInspectable var placeHolderText: String = "" {
        didSet {
            lblPlaceholder.text = placeHolderText
        }
    }
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        initNib()
        configureUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initNib()
        configureUI()
    }

    // MARK: - PrivateMethods
    fileprivate func initNib() {
        let bundle = Bundle(for: CustomTextField.self)
        bundle.loadNibNamed(String(describing: CustomTextField.self), owner: self, options: nil)
        addSubview(containerView)
        containerView.frame = bounds
        containerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    fileprivate func configureUI() {
        btnClearInput.isHidden = (txtInput.text?.isEmpty ?? true)
        txtInput.delegate = self
    }
    
    // MARK: - Public Methods
    func setup(placeHolderText: String, inputType: TypeFieldEnum) {
        lblPlaceholder.text = placeHolderText
    }
    
    // MARK: - Actions
    @IBAction func clearInput(_ sender: Any) {
        txtInput.text = ""
    }
    
    // MARK: - UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        lblPlaceholder.font = lblPlaceholder.font.withSize(11)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if txtInput.text?.isEmpty ?? true {
            lblPlaceholder.font = lblPlaceholder.font.withSize(16)
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        btnClearInput.isHidden = (txtInput.text?.isEmpty ?? true)
    }
}
