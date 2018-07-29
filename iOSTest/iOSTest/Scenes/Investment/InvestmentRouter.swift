//
//  InvestmentRouter.swift
//  iOSTest
//
//  Created by erick.peripolli on 29/07/18.
//  Copyright (c) 2018 Erick Peripolli. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

@objc protocol InvestmentRoutingLogic
{
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol InvestmentDataPassing
{
  var dataStore: InvestmentDataStore? { get }
}

class InvestmentRouter: NSObject, InvestmentRoutingLogic, InvestmentDataPassing
{
  weak var viewController: InvestmentViewController?
  var dataStore: InvestmentDataStore?
  
  // MARK: Routing
  
  //func routeToSomewhere(segue: UIStoryboardSegue?)
  //{
  //  if let segue = segue {
  //    let destinationVC = segue.destination as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //  } else {
  //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
  //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //    navigateToSomewhere(source: viewController!, destination: destinationVC)
  //  }
  //}

  // MARK: Navigation
  
  //func navigateToSomewhere(source: InvestmentViewController, destination: SomewhereViewController)
  //{
  //  source.show(destination, sender: nil)
  //}
  
  // MARK: Passing data
  
  //func passDataToSomewhere(source: InvestmentDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}
