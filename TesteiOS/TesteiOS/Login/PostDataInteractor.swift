//
//  PostDataInteractor.swift
//  TesteiOS
//
//  Created by Gabriel Soria Souza on 22/10/18.
//  Copyright © 2018 Gabriel Sória Souza. All rights reserved.
//

import Foundation
import UIKit


protocol PostToEndpoint {
    func post(dataToBePosted: DetailDataToBePosted, viewController: LoginViewController)
}

protocol ToBePosted {
    var data: DetailDataToBePosted! { get set }
}

class PostDataInteractor: PostToEndpoint, ToBePosted {
    
    var presenter: DataToBePostedPresenter?
    var data: DetailDataToBePosted!
    
    func post(dataToBePosted: DetailDataToBePosted, viewController: LoginViewController) {
        let loginData = UserDataForLogin(userId: dataToBePosted.userId, name: dataToBePosted.name, bankAccount: dataToBePosted.bankAccount, agency: dataToBePosted.agency, balance: dataToBePosted.balance)
        let completeLoginData = LoginData.init(userData: loginData, error: nil)
        
        
        RequestAndPostData.postData(loginData: completeLoginData, completion: { (sucess) in
            DispatchQueue.main.async {
                viewController.performSegue(withIdentifier: "segue", sender: nil)
                viewController.activityIndicator.stopAnimating()
                viewController.activityIndicator.removeFromSuperview()
                viewController.view.alpha = 1.0
            }
        }) { (error) in
            viewController.activityIndicator.stopAnimating()
            viewController.activityIndicator.removeFromSuperview()
            viewController.view.alpha = 1.0
        }
    }
}
