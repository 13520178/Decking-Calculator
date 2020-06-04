//
//  ResultController.swift
//  Decking Calculator
//
//  Created by Phan Đăng on 6/3/20.
//  Copyright © 2020 Phan Đăng. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ResultController: UIViewController,GADBannerViewDelegate {
    
    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var heightFromInputToResultViewConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var numberOfBoardLabel: UILabel!
    @IBOutlet weak var screwsTextfield: UITextField!
    @IBOutlet weak var hiddenClipTextfield: UITextField!
    @IBOutlet weak var priceForAllBoardTextfield: UITextField!
    @IBOutlet weak var totalCostTextfield: UITextField!
    
    @IBOutlet weak var numberOfBoardResultButton: UIButton!
    @IBOutlet weak var costEstimationsView: UIView!
    @IBOutlet weak var numberOfBoardsView: UIView!
    @IBOutlet weak var fastenersUsedView: UIView!
    
    var boardNeeded = 0.0
    var screws = 0.0
    var hiddenClip = 0.0
    var priceNeeded = 0.0
    var totalCost = 0.0
    
    var boardNeededNotWaste = 0.0
    
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !defaults.bool(forKey: "isRemoveAds"){
            bannerView.delegate = self
            bannerView.adUnitID = "ca-app-pub-9626752563546060/1262641551"
            //bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716" //Sample
            bannerView.rootViewController = self
            bannerView.load(GADRequest())
        }

        numberOfBoardsView.layer.borderColor = #colorLiteral(red: 0.6352941176, green: 0.5176470588, blue: 0.368627451, alpha: 1)
        numberOfBoardsView.layer.borderWidth = 1
        
        fastenersUsedView.layer.borderColor = #colorLiteral(red: 0.6352941176, green: 0.5176470588, blue: 0.368627451, alpha: 1)
        fastenersUsedView.layer.borderWidth = 1
        
        costEstimationsView.layer.borderColor = #colorLiteral(red: 0.6352941176, green: 0.5176470588, blue: 0.368627451, alpha: 1)
        costEstimationsView.layer.borderWidth = 1
        
        numberOfBoardResultButton.layer.borderColor = #colorLiteral(red: 0.6352941176, green: 0.5176470588, blue: 0.368627451, alpha: 1)
        numberOfBoardResultButton.layer.borderWidth = 1

        
        numberOfBoardLabel.text = "\(Tools.changeToCurrency(moneyStr: boardNeeded)!)"
        screwsTextfield.text = "\(Tools.changeToCurrency(moneyStr: screws)!)"
        hiddenClipTextfield.text = "\(Tools.changeToCurrency(moneyStr: hiddenClip)!)"
        priceForAllBoardTextfield.text = "$ \(Tools.changeToCurrency(moneyStr: priceNeeded)!)"
        totalCostTextfield.text = "$ \(Tools.changeToCurrency(moneyStr: totalCost)!)"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if !defaults.bool(forKey: "isRemoveAds") {
        }else {
            self.bannerView.isHidden = true
            self.heightFromInputToResultViewConstraint.constant = 24
        }
    }
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        UIView.animate(withDuration: 1, animations: {
            self.heightFromInputToResultViewConstraint.constant = 300
        })
    }
    
    @IBAction func numberOfBoardAlertButtonPressed(_ sender: UIButton) {
        AlertService.showInfoAlert(in: self, title: "Number of boards", message: "As a result, the number of boards below has been added to 10% of waste. The exact number of boards without waste is: \(Tools.changeToCurrency(moneyStr: boardNeededNotWaste)!)")
    }
    

  
}
