//
//  InfoController.swift
//  Decking Calculator
//
//  Created by Phan Đăng on 6/3/20.
//  Copyright © 2020 Phan Đăng. All rights reserved.
//

import UIKit
import MessageUI
import StoreKit

class InfoController: UIViewController, MFMailComposeViewControllerDelegate ,SKPaymentTransactionObserver  {

     let defaults = UserDefaults.standard
       
       @IBOutlet weak var removeAdsLabel: UILabel!
       @IBOutlet weak var reportView: UIView!
       @IBOutlet weak var resourceView: UIView!
       @IBOutlet weak var stairCalculatorView: UIView!
       @IBOutlet weak var tileCalculatorView: UIView!
       @IBOutlet weak var removeAdsView: UIView!
       @IBOutlet weak var restoreView: UIView!
       
       
       override func viewDidLoad() {
           super.viewDidLoad()
           
           SKPaymentQueue.default().add(self)
           
           let reportTap = UITapGestureRecognizer(target: self, action: #selector(sentMail))
           reportView.addGestureRecognizer(reportTap)
           
           let resourceTap = UITapGestureRecognizer(target: self, action: #selector(showResource))
           resourceView.addGestureRecognizer(resourceTap)
           
           let removeAdsTap = UITapGestureRecognizer(target: self, action: #selector(removeAds))
           removeAdsView.addGestureRecognizer(removeAdsTap)
           
           let stairTap = UITapGestureRecognizer(target: self, action: #selector(openStair))
           stairCalculatorView.addGestureRecognizer(stairTap)
           
           let tileTap = UITapGestureRecognizer(target: self, action: #selector(openTile))
           tileCalculatorView.addGestureRecognizer(tileTap)
           let restoreTab = UITapGestureRecognizer(target: self, action: #selector(restoreIAP))
           restoreView.addGestureRecognizer(restoreTab)
           
       
       }
       
       override func viewWillAppear(_ animated: Bool) {
           if !defaults.bool(forKey: "isRemoveAds") {
               removeAdsLabel.text = "Remove ads & Support Us"
           }else {
               removeAdsLabel.text = "Thank you for supporting us"
           }
       }
       
       @objc func restoreIAP() {
           SKPaymentQueue.default().restoreCompletedTransactions()
       }
       
       @objc func removeAds() {
           if !defaults.bool(forKey: "isRemoveAds") {
               AlertService.showInfoAlertAndComfirm(in: self, title: "Remove Ads", message: "Remove ads and supporting our development") {isOK in
                   if isOK {
                       if SKPaymentQueue.canMakePayments() {
                           let paymentRequest = SKMutablePayment()
                           paymentRequest.productIdentifier = "PhanNhatDang.DeckingCalculator.removeAds"
                           SKPaymentQueue.default().add(paymentRequest)
                       }else {
                           print("User unable to make payments")
                       }
                   }else {
                       SKPaymentQueue.default().restoreCompletedTransactions()
                   }
                   
               }
               return
           }
       }
       
       @objc func showResource() {
           AlertService.showInfoAlert(in: self, title: "Resource", message: "Icons: www.icons8.com")
           
       }
       
       @objc func openTile() {
           if let url = URL(string: "https://apps.apple.com/app/tile-calculator-estimator/id1512725104"),
               UIApplication.shared.canOpenURL(url)
           {
               if #available(iOS 10.0, *) {
                   UIApplication.shared.open(url, options: [:], completionHandler: nil)
               } else {
                   UIApplication.shared.openURL(url)
               }
           }
       }
       
       @objc func openStair() {
           if let url = URL(string: "https://apps.apple.com/app/stair-stringer-calculator/id1493037366"),
               UIApplication.shared.canOpenURL(url)
           {
               if #available(iOS 10.0, *) {
                   UIApplication.shared.open(url, options: [:], completionHandler: nil)
               } else {
                   UIApplication.shared.openURL(url)
               }
           }
       }
       
       
       func configureMailController() -> MFMailComposeViewController {
           let mailComposerVC = MFMailComposeViewController()
           mailComposerVC.mailComposeDelegate = self
           
           mailComposerVC.setToRecipients(["phannhatd@gmail.com"])
           mailComposerVC.setSubject("Question about Decking Calculator")
           mailComposerVC.setMessageBody("", isHTML: false)
           
           return mailComposerVC
       }
       
       func showMailError() {
           let sendMailErrorAlert = UIAlertController(title: "Unable to send mail", message: "Your device cannot send mail", preferredStyle: .alert)
           let dismiss = UIAlertAction(title: "Ok", style: .default, handler: nil)
           sendMailErrorAlert.addAction(dismiss)
           self.present(sendMailErrorAlert, animated: true, completion: nil)
       }
       
       func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
           controller.dismiss(animated: true, completion: nil)
       }
       
       @objc func sentMail() {
           let mailComposeViewController = configureMailController()
           if MFMailComposeViewController.canSendMail() {
               self.present(mailComposeViewController, animated: true, completion: nil)
           } else {
               showMailError()
           }
           
       }
       @IBAction func seeAllButtonPressed(_ sender: UIButton) {
       }
       
       func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
            for transaction in transactions {
                if transaction.transactionState == .purchased {
                    defaults.set(true, forKey: "isRemoveAds")
                    print("Transaction successful")
                    SKPaymentQueue.default().finishTransaction(transaction)
                   removeAdsLabel.text = "Thank you for supporting us"
                }else if transaction.transactionState == .failed {
                    print("Transaction failed")
                    SKPaymentQueue.default().finishTransaction(transaction)
                }else if transaction.transactionState == .restored {
                    defaults.set(true, forKey: "isRemoveAds")
                    print("Transaction successful")
                    SKPaymentQueue.default().finishTransaction(transaction)
                    print("ReStore ok")
                   AlertService.showInfoAlert(in: self, title: "Restore", message: "Your restore has completed!")
                   removeAdsLabel.text = "Thank you for supporting us"
                }
            }
        }

}
