//
//  InvestimentosInteractor.swift
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

protocol InvestimentosBusinessLogic{
    func fetchInvestimento(request: Investimentos.Something.Request)
}

protocol InvestimentosDataStore{
    //var name: String { get set }
}

class InvestimentosInteractor: InvestimentosBusinessLogic, InvestimentosDataStore{
    var presenter: InvestimentosPresentationLogic?
    var worker: InvestimentosWorker?
    //var name: String = ""
    
    // MARK: Do something
    
    func fetchInvestimento(request: Investimentos.Something.Request){
        worker = InvestimentosWorker()
        worker?.fetchInvestimento(onCompletion: { invest in
            let response = Investimentos.Something.Response(investimentos: invest)
            self.presenter?.presentInvestimentos(response: response)
        })
        
        
    }
}
