//
//  ProductView.swift
//  Santander
//
//  Created by Jonathan Martins on 04/01/19.
//  Copyright © 2019 Surrey. All rights reserved.
//

import UIKit

protocol ProductViewDelegate {
    
}

class ProductView: UIView {
    
    /// The list of favorited movies
    let tableView:UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle  = .none
        tableView.tableFooterView = UIView()
        //tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    /// Sets up the constraints for the views
    private func setupConstraints(){
        self.addSubview(tableView)
        
        self.backgroundColor = .white
        NSLayoutConstraint.activate([
            tableView.topAnchor     .constraint(equalTo: self.topAnchor, constant: 100),
            tableView.bottomAnchor  .constraint(equalTo: self.bottomAnchor),
            tableView.leadingAnchor .constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
