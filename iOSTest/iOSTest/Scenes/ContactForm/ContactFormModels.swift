//
//  ContactFormModels.swift
//  iOSTest
//
//  Created by erick.peripolli on 30/07/18.
//  Copyright (c) 2018 Erick Peripolli. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum ContactForm
{
  // MARK: Use cases
  enum GetContactCells {
    struct Request {
    }
    struct Response {
        let contactCells: ContactCells
    }
    struct ViewModel {
        let id: Int
        let type: Type
        let message: String
        let typefield: TypeField
        var hidden: Bool
        let topSpacing: Float
        let show: Int?
        let required: Bool
    }
  }
}
