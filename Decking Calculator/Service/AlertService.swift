//
//  AlertService.swift
//  MulchCalculator
//
//  Created by Phan Đăng on 5/4/20.
//  Copyright © 2020 Phan Đăng. All rights reserved.
//

import Foundation
import UIKit

class AlertService {
    
    //MARK: - Comfirm purchase IAP
    static func showInfoAlertAndComfirm(in vc: UIViewController, title:String, message:String, completion: @escaping (_ okOrRestore: Bool)->Void)  {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default) { (_) in
            completion(true)
        }
        
        let restore = UIAlertAction(title: "Restore", style: .default) { (_) in
            completion(false)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(restore)
        alert.addAction(ok)
        alert.addAction(cancel)
        vc.present(alert,animated: true )
    }
    
    static func showInfoAlert(in vc: UIViewController, title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(ok)
        vc.present(alert,animated: true )
    }

    
    static func showShapeInTypeButton(in vc:UIViewController, completion: @escaping ( _ actionType: Int)->Void)  {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        
        alert.addAction(UIAlertAction(title: "Rectangular", style: .default , handler:{ (UIAlertAction)in
            completion(0)
        }))
        
        alert.addAction(UIAlertAction(title: "Area", style: .default , handler:{ (UIAlertAction)in
            completion(1)
        }))
        
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{ (UIAlertAction)in
            print("User click Dismiss button")
        }))
        
        if let popoverController = alert.popoverPresentationController {
            popoverController.sourceView = vc.view
            popoverController.sourceRect = CGRect(x: vc.view.bounds.midX, y: vc.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        vc.present(alert, animated: true)
    }
    
    static func showBasicUnitButton(in vc:UIViewController, completion: @escaping ( _ actionType: Int)->Void)  {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        
        alert.addAction(UIAlertAction(title: "in", style: .default , handler:{ (UIAlertAction)in
            completion(1)
        }))
        
        alert.addAction(UIAlertAction(title: "ft", style: .default , handler:{ (UIAlertAction)in
            completion(2)
        }))
        alert.addAction(UIAlertAction(title: "yd", style: .default , handler:{ (UIAlertAction)in
            completion(3)
        }))
        
        alert.addAction(UIAlertAction(title: "cm", style: .default , handler:{ (UIAlertAction)in
            completion(4)
        }))
        
        alert.addAction(UIAlertAction(title: "m", style: .default , handler:{ (UIAlertAction)in
            completion(5)
        }))
        
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{ (UIAlertAction)in
            print("User click Dismiss button")
        }))
        
        if let popoverController = alert.popoverPresentationController {
            popoverController.sourceView = vc.view
            popoverController.sourceRect = CGRect(x: vc.view.bounds.midX, y: vc.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        vc.present(alert, animated: true)
    }
    
    static func showGapSizeUnitButton(in vc:UIViewController, completion: @escaping ( _ actionType: Int)->Void)  {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        
        alert.addAction(UIAlertAction(title: "in", style: .default , handler:{ (UIAlertAction)in
            completion(1)
        }))
        
        alert.addAction(UIAlertAction(title: "ft", style: .default , handler:{ (UIAlertAction)in
            completion(2)
        }))
        alert.addAction(UIAlertAction(title: "yd", style: .default , handler:{ (UIAlertAction)in
            completion(3)
        }))
        alert.addAction(UIAlertAction(title: "mm", style: .default , handler:{ (UIAlertAction)in
            completion(4)
        }))
        
        alert.addAction(UIAlertAction(title: "cm", style: .default , handler:{ (UIAlertAction)in
            completion(5)
        }))
        
        alert.addAction(UIAlertAction(title: "m", style: .default , handler:{ (UIAlertAction)in
            completion(6)
        }))
        
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{ (UIAlertAction)in
            print("User click Dismiss button")
        }))
        
        if let popoverController = alert.popoverPresentationController {
            popoverController.sourceView = vc.view
            popoverController.sourceRect = CGRect(x: vc.view.bounds.midX, y: vc.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        vc.present(alert, animated: true)
    }
    
    static func showAreaUnitButton(in vc:UIViewController, completion: @escaping ( _ actionType: Int)->Void)  {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        
        alert.addAction(UIAlertAction(title: "in²", style: .default , handler:{ (UIAlertAction)in
            completion(1)
        }))
        
        alert.addAction(UIAlertAction(title: "ft²", style: .default , handler:{ (UIAlertAction)in
            completion(2)
        }))
        alert.addAction(UIAlertAction(title: "yd²", style: .default , handler:{ (UIAlertAction)in
            completion(3)
        }))
        
        alert.addAction(UIAlertAction(title: "cm²", style: .default , handler:{ (UIAlertAction)in
            completion(4)
        }))
        
        alert.addAction(UIAlertAction(title: "m²", style: .default , handler:{ (UIAlertAction)in
            completion(5)
        }))
        
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{ (UIAlertAction)in
            print("User click Dismiss button")
        }))
        
        if let popoverController = alert.popoverPresentationController {
            popoverController.sourceView = vc.view
            popoverController.sourceRect = CGRect(x: vc.view.bounds.midX, y: vc.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        vc.present(alert, animated: true)
    }
    

    
    static func showPriceUnitButton(in vc:UIViewController, completion: @escaping ( _ actionType: Int)->Void)  {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        
        alert.addAction(UIAlertAction(title: "per tile", style: .default , handler:{ (UIAlertAction)in
            completion(1)
        }))
        
        alert.addAction(UIAlertAction(title: "per box", style: .default , handler:{ (UIAlertAction)in
            completion(2)
        }))
        alert.addAction(UIAlertAction(title: "per in²", style: .default , handler:{ (UIAlertAction)in
            completion(3)
        }))
        alert.addAction(UIAlertAction(title: "per ft²", style: .default , handler:{ (UIAlertAction)in
            completion(4)
        }))
        alert.addAction(UIAlertAction(title: "per yd²", style: .default , handler:{ (UIAlertAction)in
            completion(5)
        }))
        alert.addAction(UIAlertAction(title: "per cm²", style: .default , handler:{ (UIAlertAction)in
            completion(6)
        }))
        alert.addAction(UIAlertAction(title: "per m²", style: .default , handler:{ (UIAlertAction)in
            completion(7)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{ (UIAlertAction)in
            print("User click Dismiss button")
        }))
        
        if let popoverController = alert.popoverPresentationController {
            popoverController.sourceView = vc.view
            popoverController.sourceRect = CGRect(x: vc.view.bounds.midX, y: vc.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        vc.present(alert, animated: true)
    }
    
   
}
