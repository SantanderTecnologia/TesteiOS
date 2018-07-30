//
//  ContactPresenter.swift
//  TesteiOS
//
//  Created by Tiago Leme on 28/07/18.
//  Copyright (c) 2018 Tiago Leme. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ContactPresentationLogic
{
  func presentDynamicCells(response: Contact.FetchDynamicCells.Response)
}

class ContactPresenter: ContactPresentationLogic
{
  weak var viewController: ContactDisplayLogic?
  
  // MARK: Do something
  
  func presentDynamicCells(response: Contact.FetchDynamicCells.Response) {
    
    var displayableCells: [Contact.FetchDynamicCells.ViewModel.DisplayableCell] = []
    for cell in response.dynamicCells {
        let displayableCell = Contact.FetchDynamicCells.ViewModel.DisplayableCell(id: cell.id,
                                                                                  type: cell.type,
                                                                                  message: cell.message,
                                                                                  typeField: cell.typeField,
                                                                                  hidden: cell.hidden,
                                                                                  topSpacing: cell.topSpacing,
                                                                                  show: cell.show,
                                                                                  isRequired: cell.isRequired)
        displayableCells.append(displayableCell)
        
    }
    
    let viewModel = Contact.FetchDynamicCells.ViewModel(displayableCells: displayableCells)
    viewController?.displayDynamicCells(viewModel: viewModel)
  }
}
