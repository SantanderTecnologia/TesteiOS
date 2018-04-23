//
//  FundModels.swift
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

enum FundModel{
    // MARK: Use cases
    
    enum Screen{
        struct Request{}
        struct Response{
            var funds: [Fund]
        }
        struct ViewModel{
            var funds: [Fund]
        }
    }
}
