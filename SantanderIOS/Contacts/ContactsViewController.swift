//
//  ContactsViewController.swift
//  santanderTest
//
//  Created by Adauto Oliveira on 26/05/19.
//  Copyright (c) 2019 Adauto Oliveira. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import UICheckbox_Swift


protocol ContactsDisplayLogic: class
{
  func displaySomething(viewModel: Contacts.Something.ViewModel)
}

class ContactsViewController: UITableViewController, ContactsDisplayLogic, UITextFieldDelegate{
  var interactor: ContactsBusinessLogic?
  var router: (NSObjectProtocol & ContactsRoutingLogic & ContactsDataPassing)?

  // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
  {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder)
  {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  
  private func setup()
  {
    let viewController = self
    let interactor = ContactsInteractor()
    let presenter = ContactsPresenter()
    let router = ContactsRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }
  
  // MARK: Routing
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    if let scene = segue.identifier {
      let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
      if let router = router, router.responds(to: selector) {
        router.perform(selector, with: segue)
      }
    }
  }
  
  // MARK: View lifecycle
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    doSomething()
  }
  
  // MARK: Do something
    
    var displayedForms: [Contacts.Something.ViewModel.DisplayedForm] = []
    
    func doSomething()
    {
        let request = Contacts.Something.Request()
        interactor?.doSomething(request: request)
    }
    
    func displaySomething(viewModel: Contacts.Something.ViewModel)
    {
        //ameTextField.text = viewModel.name
        displayedForms = viewModel.diplayedForm
       tableView.reloadData()
        
        
    }

  
  //@IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPhone: UITextField!
    
    @IBOutlet weak var checkButton: UICheckbox!
    @IBOutlet weak var viewMessage: UIView!
    @IBOutlet var textFields: [UITextField]!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let index = textFields.firstIndex(of: textField){
            if index < textFields.count - 1 {
                let nextTextField = textFields[index + 1]
                nextTextField.becomeFirstResponder()
            }
        }
        return true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath){
            for textField in textFields{
                if textField.isDescendant(of: cell){
                    textField.resignFirstResponder()
                }
            }
        }
    }
    
    func teste (){
        
    }
    
    func validarTextField (textFields: [UITextField]) -> Bool{
        var allOK : Bool = true
        
        for textField in textFields {
            if textField.text == ""{
                allOK = false
                let alert: UIAlertController = UIAlertController(title: "Campos não preenchidos", message: "Preencha os campos corretamente", preferredStyle: .alert)
                
                let actionOk: UIAlertAction = UIAlertAction(title: "Ok", style: .default) { (acao) in
                    
                    
                }
                
                alert.addAction(actionOk)
                self.present(alert, animated: true, completion: nil)
                break
            }
        }
        
        return allOK
    }
    
    
    @IBAction func sendBtn(_ sender: UIButton) {
        
        if validarTextField(textFields: textFields) == true {
            self.viewMessage.isHidden = false
            
        }
        
    }
    
    @IBAction func newMessageBtn(_ sender: UIButton) {
        
        self.viewMessage.isHidden = true
        self.tfName.text = ""
        self.tfEmail.text = ""
        self.tfPhone.text = ""
        
        if checkButton.isSelected == true {
            checkButton.isSelected = false
        }
        
        
        
    }
    
}
