//
//  MainView.swift
//  InvestmentApp
//
//  Created by Matheus Weber on 22/04/18.
//  Copyright © 2018 Matheus Weber. All rights reserved.
//

import UIKit
import SnapKit

protocol MainViewProtocol: class {
    func didChangeTab(type: ScreenType)
}

class MainView: UIView, ViewConfigurationProtocol {
    weak var delegate: MainViewProtocol?
    
    lazy var investementView: InvestmentView = {
        let investementView = InvestmentView()
        return investementView
    }()
    
    lazy var contactView: ContactView = {
        let contactView = ContactView()
        contactView.isHidden = true
        return contactView
    }()
    
    var segmentedControl = SegmentedControl(items: ["Investimento", "Contato"])
    
    init() {
        super.init(frame: CGRect.zero)
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

extension MainView {
    func setup(littleTitle: String, title: String, descriptionTitle: String, descriptionText: String, risk: String, riskSelected: Int, info: String) {
        
        investementView.setup(littleTitle: littleTitle, title: title, descriptionTitle: descriptionTitle, descriptionText: descriptionText, risk: risk, riskSelected: riskSelected, info: info)
        
        segmentedControl.delegate = self
        setupView()
    }
    
    func setupItems() {
        self.backgroundColor = UIColor.white
        
        addSubview(investementView)
        addSubview(contactView)
        addSubview(segmentedControl)
    }
    
    func setupLayout() {
        investementView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(0)
            make.bottom.equalTo(segmentedControl.snp.top)
        }
        
        contactView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(0)
            make.bottom.equalTo(segmentedControl.snp.top)
        }
        
        segmentedControl.snp.makeConstraints { (make) in
            make.bottom.equalTo(0)
            make.left.right.equalTo(0)
            make.height.equalTo(55)
        }
    }
    
    func updateTable() {
        investementView.tableView.snp.makeConstraints { (make) in
            make.height.equalTo(investementView.tableView.contentSize.height)
        }
        
        contactView.tableView.snp.makeConstraints { (make) in
            make.height.equalTo(contactView.tableView.contentSize.height + 40)
        }
    }
}

extension MainView: SegmentedControlDelegate {
    func didChangeTab(index: Int) {
        if index == 0 {
            investementView.isHidden = false
            contactView.isHidden = true
            delegate?.didChangeTab(type: .investiment)
        } else {
            investementView.isHidden = true
            contactView.isHidden = false
            delegate?.didChangeTab(type: .contact)
        }
    }
}
