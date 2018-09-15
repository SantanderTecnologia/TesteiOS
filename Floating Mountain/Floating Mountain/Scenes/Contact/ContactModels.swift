//
//  ContactModels.swift
//  Floating Mountain
//
//  Created by Leonardo Oliveira on 9/14/18.
//  Copyright (c) 2018 Leonardo Oliveira. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

enum Contact {
    // MARK: Use cases
    
    enum FetchForm {
        struct Request {
        }
        struct Response {
            var form: Form?
            var error: Error?
        }
        struct ViewModel {
        }
    }
}
