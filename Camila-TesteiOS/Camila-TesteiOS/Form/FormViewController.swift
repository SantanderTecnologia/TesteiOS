//
//  FormViewController.swift
//  Camila-TesteiOS
//
//  Created by camila oliveira on 20/04/18.
//  Copyright © 2018 Aliamcami. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol FormDisplayLogic: class{
    func displayCells(viewModel: FormModels.FetchCell.ViewModel)
}

class FormViewController: UIViewController, FormDisplayLogic{
    
    var interactor: FormBusinessLogic?
    var router: (NSObjectProtocol & FormRoutingLogic & FormDataPassing)?
    var displayedCells = [Cell]()
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?){
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup(){
        let viewController = self
        let interactor = FormInteractor()
        let presenter = FormPresenter()
        let router = FormRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad(){
        super.viewDidLoad()
        fetchCells()
    }
    
    // MARK: Fetch Cells
    
    func fetchCells(){
        self.interactor?.fetchCells(request: FormModels.FetchCell.Request())
    }
    
    func displayCells(viewModel: FormModels.FetchCell.ViewModel){
        displayedCells = viewModel.displayedCells
        for cell in displayedCells{
            //create each cell
        }
        
    }
}
