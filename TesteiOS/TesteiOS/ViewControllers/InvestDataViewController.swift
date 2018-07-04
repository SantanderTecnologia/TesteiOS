//
//  CellViewController.swift
//  TesteiOS
//
//  Created by Carolina Bonturi on 7/3/18.
//  Copyright © 2018 Carolina Bonturi. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class InvestDataViewController: UIViewController {

    // URL constant
    let URL = "https://floating-mountain-50292.herokuapp.com/fund.json"

    // variables to handle Json data
    var fund = Fund()

    
    
    @IBOutlet weak var label1: UILabel!
    
    @IBOutlet weak var textField1: UITextField!
    
    @IBOutlet weak var line1: Line!
    
    @IBOutlet weak var label2: UILabel!
    
    @IBOutlet weak var textFIeld2: UITextField!
    
    @IBOutlet weak var line2: Line!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getData(url: URL)
    }

    
    //MARK: - Networking
    /*********************************************************************/
    public func getData(url: String) {
        
        // retrieve data from an HTTP request
        Alamofire.request(url, method: .get).responseJSON {
            // once the response comes back
            response in
            if response.result.isSuccess {
                let dataJSON : JSON = JSON(response.result.value!)
                self.updateData(json: dataJSON)
            }
                // if it did not manage to get the data
            else {
                print("Error: \(response.result.error!)")
            }
        }
    }
    
    
    //MARK: - JSON parsing
    /*********************************************************************/
    func updateData(json: JSON) {
        
        fund.title = json["screen"]["title"].stringValue
        fund.fundName = json["screen"]["fundName"].stringValue
        fund.whatIs = json["screen"]["whatIs"].stringValue
        fund.definition = json["screen"]["definition"].stringValue
        fund.riskTitle = json["screen"]["riskTitle"].stringValue
        fund.risk = json["screen"]["risk"].intValue
        fund.infoTitle = json["screen"]["infoTitle"].stringValue
        
        // moreInfo parsing
        var mi = MoreInfo()
        
        mi.fund = json["screen"]["moreInfo"]["month"]["fund"].floatValue
        mi.CDI = json["screen"]["moreInfo"]["month"]["CDI"].floatValue
        fund.moreInfo.append(mi)
        
        mi.fund = json["screen"]["moreInfo"]["year"]["fund"].floatValue
        mi.CDI = json["screen"]["moreInfo"]["year"]["CDI"].floatValue
        fund.moreInfo.append(mi)
        
        mi.fund = json["screen"]["moreInfo"]["12months"]["fund"].floatValue
        mi.CDI = json["screen"]["moreInfo"]["12months"]["CDI"].floatValue
        fund.moreInfo.append(mi)
        
        // info parsing
        var inf = Info()
        var size = json["screen"]["info"].count
        
        for item in 0..<size {
            inf.name = json["screen"]["info"][item]["name"].stringValue
            inf.data = json["screen"]["info"][item]["data"].stringValue
            
            fund.info.append(inf)
        }
        
        // downInfo parsing
        var di = Info()
        size = json["screen"]["downInfo"].count
        
        for item in 0..<size {
            di.name = json["screen"]["downInfo"][item]["name"].stringValue
            di.data = json["screen"]["downInfo"][item]["data"].stringValue

            fund.downInfo.append(di)
        }
        updateUIWithData()
    }
    
    
    //MARK: - UI Updates
    /*********************************************************************/
    func updateUIWithData() {
        
//        titleLabel.text = investment.title
//        fundNameLabel.text = investment.fundName
//        whatIsLabel.text = investment.whatIsLabel
//        definitionLabel.adjustsFontSizeToFitWidth = true
//        definitionLabel.text = investment.definition
//        riskTitleLabel.text = investment.riskTitle
//        infoTitleLabel.text = investment.infoTitle
//
//        monthFundLabel.text = "\(investment.monthFund)%"
//        monthCDILabel.text = "\(investment.monthCDI)%"
//        yearFundLabel.text = "\(investment.yearFund)%"
//        yearCDILabel.text = "\(investment.yearCDI)%"
//        twelveMonthsFundLabel.text = "\(investment.twelveMonthsFund)%"
//        twelveMonthsCDILabel.text = "\(investment.twelveMonthsCDI)%"
//
//
//
//        var index = 0
//
//        for label in infoLabels {
//
//            // if tag is odd
//            if (label.tag%2 != 0) {
//
//                label.text = info[index].name
//
//                print("ímpar: \(label.tag), index: \(index)")
//                if (label.tag >= 15) {
//                    index = index + 1
//
//                }
//
//                // if tag is even
//            } else {
//
//                label.text = info[index].data
//                index = index + 1
//
//                print("par: \(label.tag), index: \(index)")
//
//            }
//
//        }
//    }
//
        

    }
    
    
    private func lookFor(key: String, array: [Cell]) -> Int? {
        
        let size = array.count
        var dict : [String : Int] = ["name" : 1, "telNumber": 2, "email" : 3]
        
        for item in 0..<size {
            if (array[item].typefield?.rawValue == dict[key]) {
                print(item)
                return item
            } else {
                print("Key not found in array")
            }
        }
        return nil
    }
    
    



}
