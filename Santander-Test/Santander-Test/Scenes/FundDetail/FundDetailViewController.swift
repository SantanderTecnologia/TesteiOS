//
//  FundDetailViewController.swift
//  Santander-Test
//
//  Created by Matheus Ribeiro on 16/05/19.
//  Copyright (c) 2019 Matheus Ribeiro. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol FundDetailDisplayLogic: class {
    func displayFundDetail(viewModel: FundDetail.GetFundDetail.ViewModel)
    func displayError(viewModel: FundDetail.FundDetailError.ViewModel)
}

class FundDetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var displayedFund: FundDetail.GetFundDetail.ViewModel?
    
    var interactor: FundDetailBusinessLogic?
    var router: (NSObjectProtocol & FundDetailRoutingLogic & FundDetailDataPassing)?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        let viewController = self
        let interactor = FundDetailInteractor()
        let presenter = FundDetailPresenter()
        let router = FundDetailRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        requestData()
    }
    
    private func setupTableView() {
        registerTableViewCells()
    }
    
    private func requestData() {
        let request = FundDetail.GetFundDetail.Request()
        interactor?.getFundDetail(request: request)
    }
    
    private func registerTableViewCells() {
        let fundHeader = UINib(nibName: "FundHeader", bundle: nil)
        tableView.register(
            fundHeader,
            forCellReuseIdentifier: FundHeader.reuseIdentifier
        )
        
        let fundRisk = UINib(nibName: "FundRisk", bundle: nil)
        tableView.register(
            fundRisk,
            forCellReuseIdentifier: FundRisk.reuseIdentifier
        )
        
        let fundMoreInfoCell = UINib(nibName: "FundMoreInfoCell", bundle: nil)
        tableView.register(
            fundMoreInfoCell,
            forCellReuseIdentifier: FundMoreInfoCell.reuseIdentifier
        )
        
        let fundInfoCell = UINib(nibName: "FundInfoCell", bundle: nil)
        tableView.register(
            fundInfoCell,
            forCellReuseIdentifier: FundInfoCell.reuseIdentifier
        )
        
        let fundDownInfoCell = UINib(nibName: "FundDownInfoCell", bundle: nil)
        tableView.register(
            fundDownInfoCell,
            forCellReuseIdentifier: FundDownInfoCell.reuseIdentifier
        )
        
        let sendCell = UINib(nibName: "SendCell", bundle: nil)
        tableView.register(
            sendCell,
            forCellReuseIdentifier: SendCell.reuseIdentifier
        )
    }
}

extension FundDetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0, 1, 2, 5:
            return 1
        case 3:
            guard let info = displayedFund?.info else { return 0 }
            return info.count
        case 4:
            guard let downInfo = displayedFund?.downInfo else { return 0 }
            return downInfo.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: FundHeader.reuseIdentifier
                ) as! FundHeader
            if let displayedFund = displayedFund {
                cell.viewModel = FundHeader.ViewModel(
                    title: displayedFund.title,
                    fundName: displayedFund.fundName,
                    whatIs: displayedFund.whatIs,
                    definition: displayedFund.definition
                )
            }
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: FundRisk.reuseIdentifier
                ) as! FundRisk
            if let displayedFund = displayedFund {
                cell.viewModel = FundRisk.ViewModel(
                    risk: displayedFund.risk
                )
            }
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: FundMoreInfoCell.reuseIdentifier
                ) as! FundMoreInfoCell
            if let displayedFund = displayedFund {
                cell.viewModel = FundMoreInfoCell.ViewModel(
                    fundMoreInfo: displayedFund.moreInfo
                )
            }
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: FundInfoCell.reuseIdentifier
                ) as! FundInfoCell
            if let displayedFund = displayedFund {
                cell.viewModel = FundInfoCell.ViewModel(
                    infoName: displayedFund.info[indexPath.row].name,
                    infoData: displayedFund.info[indexPath.row].data
                )
            }
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: FundDownInfoCell.reuseIdentifier
                ) as! FundDownInfoCell
            if let displayedFund = displayedFund {
                cell.viewModel = FundDownInfoCell.ViewModel(
                    downInfoName: displayedFund.downInfo[indexPath.row].name
                )
            }
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: SendCell.reuseIdentifier
                ) as! SendCell
            if let displayedFund = displayedFund {
                cell.viewModel = SendCell.ViewModel(
                    message: displayedFund.buttonMessage,
                    topSpace: displayedFund.buttonTopSpace
                )
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension FundDetailViewController: FundDetailDisplayLogic {
    
    func displayFundDetail(viewModel: FundDetail.GetFundDetail.ViewModel) {
        displayedFund = viewModel
        tableView.reloadData()
    }
    
    func displayError(viewModel: FundDetail.FundDetailError.ViewModel) {
        showErrorFeedback(viewModel.message)
    }
}
