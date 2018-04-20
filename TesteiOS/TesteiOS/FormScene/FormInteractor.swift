//
//  FormInteractor.swift
//  TesteiOS
//
//  Created by Gustavo Melki on 20/04/2018.
//  Copyright (c) 2018 GustavoMelki. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import Moya
import RxSwift

protocol FormBusinessLogic
{
  func doSomething(request: Form.Request)
}

protocol FormDataStore
{
  //var name: String { get set }
}

class FormInteractor: FormBusinessLogic, FormDataStore
{
  var presenter: FormPresentationLogic?
  var worker: FormWorker?
  //var name: String = ""
  
  // MARK: Do something
  
  func doSomething(request: Form.Request)
  {
    worker = FormWorker()
    worker?.doSomeWork()
    
        FundManager.getFund().subscribe(onNext: { (fund) in
          print(fund)
          
          let response = Form.Response(screen: fund.screen)
          
          self.presenter?.presentSomething(response: response)
        }, onError: { (error) in
          print(error)
        }, onCompleted: {
          print("Completed")
        }).disposed(by: DisposeBag())
    
  
    
  }
}
