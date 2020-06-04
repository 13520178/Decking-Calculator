//
//  ViewController.swift
//  Decking Calculator
//
//  Created by Phan Đăng on 6/3/20.
//  Copyright © 2020 Phan Đăng. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ViewController: UIViewController,UITextFieldDelegate,GADBannerViewDelegate {
    
    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var heightFromInputToResultViewConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var inputAreaToCoverView: UIView!
    @IBOutlet weak var inputBoardToCoverView: UIView!
    @IBOutlet weak var inputCostView: UIView!
    
    @IBOutlet weak var areaAreaConstraint: NSLayoutConstraint! //20
    @IBOutlet weak var lengthConstraint: NSLayoutConstraint! //74
    @IBOutlet weak var widthConstraint: NSLayoutConstraint! //128
    
    @IBOutlet weak var typeButton: UIButton!
    @IBOutlet weak var deckAreaButton: UIButton!
    @IBOutlet weak var deckLengthButton: UIButton!
    @IBOutlet weak var deckWidthButton: UIButton!
    @IBOutlet weak var boardLengthButton: UIButton!
    @IBOutlet weak var boardWidthButton: UIButton!
    
    @IBOutlet weak var deckAreaTextfield: UITextField!
    @IBOutlet weak var deckLengthTextfield: UITextField!
    @IBOutlet weak var deckWidthTextfield: UITextField!
    @IBOutlet weak var boardLengthTextfield: UITextField!
    @IBOutlet weak var boardWidthTextfield: UITextField!
    @IBOutlet weak var pricePerBoardTextfield: UITextField!
    @IBOutlet weak var costOfFastenersTextfield: UITextField!
    
    @IBOutlet weak var deckAreaErrorLabel: UILabel!
    @IBOutlet weak var deckLengthErrorLabel: UILabel!
    @IBOutlet weak var deckWidthErrorLabel: UILabel!
    @IBOutlet weak var boardLengthErrorLabel: UILabel!
    @IBOutlet weak var boardWidthErrorLabel: UILabel!
    @IBOutlet weak var pricePerBoardErrorLabel: UILabel!
    @IBOutlet weak var costOfFastenersErrorLabel: UILabel!
    
    @IBOutlet weak var deckAreaStackView: UIStackView!
    @IBOutlet weak var deckLengthStackView: UIStackView!
    @IBOutlet weak var deckWidthStackView: UIStackView!
    
    var isDeckAreaOK = false
    var isDeckLengthOK = false
    var isDeckWidthOK = false
    var isLengthBoardOK = false
    var isWidthBoardOK = false
    var isPricePerBoardOK = true
    var isCostOfFastenersOK = true
    
    let defaults = UserDefaults.standard
    
    var boardNeededNotWaste = 0.0
    var boardNeeded = 0.0
    var screws = 0.0
    var hiddenClip = 0.0
    var priceNeeded = 0.0
    var totalCost = 0.0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !defaults.bool(forKey: "isRemoveAds"){
            bannerView.delegate = self
            bannerView.adUnitID = "ca-app-pub-9626752563546060/3888804896"
            //bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716" //Sample
            bannerView.rootViewController = self
            bannerView.load(GADRequest())
        }
        
        inputAreaToCoverView.layer.borderColor = #colorLiteral(red: 0.6352941176, green: 0.5176470588, blue: 0.368627451, alpha: 1)
        inputAreaToCoverView.layer.borderWidth = 1
        
        inputBoardToCoverView.layer.borderColor = #colorLiteral(red: 0.6352941176, green: 0.5176470588, blue: 0.368627451, alpha: 1)
        inputBoardToCoverView.layer.borderWidth = 1
        
        inputCostView.layer.borderColor = #colorLiteral(red: 0.6352941176, green: 0.5176470588, blue: 0.368627451, alpha: 1)
        inputCostView.layer.borderWidth = 1
        
        deckAreaTextfield.delegate = self
        deckLengthTextfield.delegate = self
        deckWidthTextfield.delegate = self
        boardLengthTextfield.delegate = self
        boardWidthTextfield.delegate = self
        pricePerBoardTextfield.delegate = self
        costOfFastenersTextfield.delegate = self
        
        if defaults.integer(forKey: "deckLength") == 0 {
            defaults.set(2, forKey: "deckLength")
            deckLengthButton.setTitle("ft", for: .normal)
        }
        
        if defaults.integer(forKey: "deckWidth") == 0 {
            defaults.set(2, forKey: "deckWidth")
            deckWidthButton.setTitle("ft", for: .normal)
        }
        
        if defaults.integer(forKey: "deckArea") == 0 {
            defaults.set(2, forKey: "deckArea")
            deckAreaButton.setTitle("ft²", for: .normal)
        }
        
        if defaults.integer(forKey: "boardLength") == 0 {
            defaults.set(2, forKey: "boardLength")
            boardLengthButton.setTitle("ft", for: .normal)
        }
        
        if defaults.integer(forKey: "boardWidth") == 0 {
            defaults.set(1, forKey: "boardWidth")
            boardWidthButton.setTitle("in", for: .normal)
        }
        
        if defaults.integer(forKey: "deckLength") == 1 {
            self.deckLengthButton.setTitle("in", for: .normal)
        }else if defaults.integer(forKey: "deckLength") == 2  {
            self.deckLengthButton.setTitle("ft", for: .normal)
        }else if defaults.integer(forKey: "deckLength") == 3  {
            self.deckLengthButton.setTitle("yd", for: .normal)
        }else if defaults.integer(forKey: "deckLength") == 4  {
            self.deckLengthButton.setTitle("cm", for: .normal)
        }else if defaults.integer(forKey: "deckLength") == 5  {
            self.deckLengthButton.setTitle("m", for: .normal)
        }
        
        if defaults.integer(forKey: "deckWidth") == 1 {
            self.deckWidthButton.setTitle("in", for: .normal)
        }else if defaults.integer(forKey: "deckWidth") == 2  {
            self.deckWidthButton.setTitle("ft", for: .normal)
        }else if defaults.integer(forKey: "deckWidth") == 3  {
            self.deckWidthButton.setTitle("yd", for: .normal)
        }else if defaults.integer(forKey: "deckWidth") == 4  {
            self.deckWidthButton.setTitle("cm", for: .normal)
        }else if defaults.integer(forKey: "deckWidth") == 5  {
            self.deckWidthButton.setTitle("m", for: .normal)
        }
        
        if defaults.integer(forKey: "deckArea") == 1 {
            self.deckAreaButton.setTitle("in²", for: .normal)
        }else if defaults.integer(forKey: "deckArea") == 2  {
            self.deckAreaButton.setTitle("ft²", for: .normal)
        }else if defaults.integer(forKey: "deckArea") == 3  {
            self.deckAreaButton.setTitle("yd²", for: .normal)
        }else if defaults.integer(forKey: "deckArea") == 4  {
            self.deckAreaButton.setTitle("cm²", for: .normal)
        }else if defaults.integer(forKey: "deckArea") == 5  {
            self.deckAreaButton.setTitle("m²", for: .normal)
        }
        
        if defaults.integer(forKey: "boardLength") == 1 {
            self.boardLengthButton.setTitle("in", for: .normal)
        }else if defaults.integer(forKey: "boardLength") == 2  {
            self.boardLengthButton.setTitle("ft", for: .normal)
        }else if defaults.integer(forKey: "boardLength") == 3  {
            self.boardLengthButton.setTitle("yd", for: .normal)
        }else if defaults.integer(forKey: "boardLength") == 4  {
            self.boardLengthButton.setTitle("cm", for: .normal)
        }else if defaults.integer(forKey: "boardLength") == 5  {
            self.boardLengthButton.setTitle("m", for: .normal)
        }
        
        if defaults.integer(forKey: "boardWidth") == 1 {
            self.boardWidthButton.setTitle("in", for: .normal)
        }else if defaults.integer(forKey: "boardWidth") == 2  {
            self.boardWidthButton.setTitle("ft", for: .normal)
        }else if defaults.integer(forKey: "boardWidth") == 3  {
            self.boardWidthButton.setTitle("yd", for: .normal)
        }else if defaults.integer(forKey: "boardWidth") == 4  {
            self.boardWidthButton.setTitle("cm", for: .normal)
        }else if defaults.integer(forKey: "boardWidth") == 5  {
            self.boardWidthButton.setTitle("m", for: .normal)
        }
        
        if defaults.integer(forKey: "type") == 0 {
            self.typeButton.setTitle("Rectangular", for: .normal)
            inputConstructer(length: true, width: true, area: false)
        }else if defaults.integer(forKey: "type") == 1 {
            self.typeButton.setTitle("Area", for: .normal)
            inputConstructer(length: false, width: false, area: true)
        }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if !defaults.bool(forKey: "isRemoveAds") {
        }else {
            self.bannerView.isHidden = true
            self.heightFromInputToResultViewConstraint.constant = 36
        }
        
    }
    
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        UIView.animate(withDuration: 1, animations: {
            self.heightFromInputToResultViewConstraint.constant = 330
        })
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //0: Nhập số sai
        //1: Âm
        //2: Quá cao
        //-1 : OK
        
        if textField == deckLengthTextfield {
            let indexCode = Tools.textDecimalValid(inputText: textField.text!)
            if indexCode != -1 && indexCode != -2 {
                isDeckLengthOK = false
                deckLengthTextfield.backgroundColor = #colorLiteral(red: 0.9768655896, green: 0.5316846371, blue: 0.5128982067, alpha: 1)
                deckLengthErrorLabel.isHidden = false
                if indexCode == 1 {
                    deckLengthErrorLabel.text = "Cannot be a negative number"
                }else if indexCode == 2{
                    deckLengthErrorLabel.text = "The number is too big"
                }else if indexCode == 0 {
                    deckLengthErrorLabel.text = "Must be a decimal number (Ex 2.35)"
                }
            }else {
                deckLengthTextfield.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
                deckLengthErrorLabel.isHidden = true
                isDeckLengthOK = true
            }
        }
        
        if textField == deckWidthTextfield {
            let indexCode = Tools.textDecimalValid(inputText: textField.text!)
            if indexCode != -1 && indexCode != -2 {
                isDeckWidthOK = false
                deckWidthTextfield.backgroundColor = #colorLiteral(red: 0.9768655896, green: 0.5316846371, blue: 0.5128982067, alpha: 1)
                deckWidthErrorLabel.isHidden = false
                if indexCode == 1 {
                    deckWidthErrorLabel.text = "Cannot be a negative number"
                }else if indexCode == 2{
                    deckWidthErrorLabel.text = "The number is too big"
                }else if indexCode == 0 {
                    deckWidthErrorLabel.text = "Must be a decimal number (Ex 2.35)"
                }
            }else {
                deckWidthTextfield.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
                deckWidthErrorLabel.isHidden = true
                isDeckWidthOK = true
            }
        }
        
        
        if textField == deckAreaTextfield {
            let indexCode = Tools.textDecimalValid(inputText: textField.text!)
            if indexCode != -1 && indexCode != -2 {
                isDeckAreaOK = false
                deckAreaTextfield.backgroundColor = #colorLiteral(red: 0.9768655896, green: 0.5316846371, blue: 0.5128982067, alpha: 1)
                deckAreaErrorLabel.isHidden = false
                if indexCode == 1 {
                    deckAreaErrorLabel.text = "Cannot be a negative number"
                }else if indexCode == 2{
                    deckAreaErrorLabel.text = "The number is too big"
                }else if indexCode == 0 {
                    deckAreaErrorLabel.text = "Must be a decimal number (Ex 2.35)"
                }
            }else {
                deckAreaTextfield.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
                deckAreaErrorLabel.isHidden = true
                isDeckAreaOK = true
            }
        }
        
        if textField == boardLengthTextfield {
            let indexCode = Tools.textDecimalValid(inputText: textField.text!)
            if indexCode != -1 && indexCode != -2 {
                isLengthBoardOK = false
                boardLengthTextfield.backgroundColor = #colorLiteral(red: 0.9768655896, green: 0.5316846371, blue: 0.5128982067, alpha: 1)
                boardLengthErrorLabel.isHidden = false
                if indexCode == 1 {
                    boardLengthErrorLabel.text = "Cannot be a negative number"
                }else if indexCode == 2{
                    boardLengthErrorLabel.text = "The number is too big"
                }else if indexCode == 0 {
                    boardLengthErrorLabel.text = "Must be a decimal number (Ex 2.35)"
                }
            }else {
                boardLengthTextfield.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
                boardLengthErrorLabel.isHidden = true
                isLengthBoardOK = true
            }
        }
        
        if textField == boardWidthTextfield {
            let indexCode = Tools.textDecimalValid(inputText: textField.text!)
            if indexCode != -1 && indexCode != -2 {
                isWidthBoardOK = false
                boardWidthTextfield.backgroundColor = #colorLiteral(red: 0.9768655896, green: 0.5316846371, blue: 0.5128982067, alpha: 1)
                boardWidthErrorLabel.isHidden = false
                if indexCode == 1 {
                    boardWidthErrorLabel.text = "Cannot be a negative number"
                }else if indexCode == 2{
                    boardWidthErrorLabel.text = "The number is too big"
                }else if indexCode == 0 {
                    boardWidthErrorLabel.text = "Must be a decimal number (Ex 2.35)"
                }
            }else {
                boardWidthTextfield.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
                boardWidthErrorLabel.isHidden = true
                isWidthBoardOK = true
            }
        }
        
        if textField == pricePerBoardTextfield {
            let indexCode = Tools.textDecimalValid(inputText: textField.text!)
            if indexCode != -1 && indexCode != -2 {
                isPricePerBoardOK = false
                pricePerBoardTextfield.backgroundColor = #colorLiteral(red: 0.9768655896, green: 0.5316846371, blue: 0.5128982067, alpha: 1)
                pricePerBoardErrorLabel.isHidden = false
                if indexCode == 1 {
                    pricePerBoardErrorLabel.text = "Cannot be a negative number"
                }else if indexCode == 2{
                    pricePerBoardErrorLabel.text = "The number is too big"
                }else if indexCode == 0 {
                    pricePerBoardErrorLabel.text = "Must be a decimal number (Ex 2.35)"
                }
            }else {
                pricePerBoardTextfield.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
                pricePerBoardErrorLabel.isHidden = true
                isPricePerBoardOK = true
            }
        }
        
        if textField == costOfFastenersTextfield {
            let indexCode = Tools.textDecimalValid(inputText: textField.text!)
            if indexCode != -1 && indexCode != -2 {
                isCostOfFastenersOK = false
                costOfFastenersTextfield.backgroundColor = #colorLiteral(red: 0.9768655896, green: 0.5316846371, blue: 0.5128982067, alpha: 1)
                costOfFastenersErrorLabel.isHidden = false
                if indexCode == 1 {
                    costOfFastenersErrorLabel.text = "Cannot be a negative number"
                }else if indexCode == 2{
                    costOfFastenersErrorLabel.text = "The number is too big"
                }else if indexCode == 0 {
                    costOfFastenersErrorLabel.text = "Must be a decimal number (Ex 2.35)"
                }
            }else {
                costOfFastenersTextfield.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
                costOfFastenersErrorLabel.isHidden = true
                isCostOfFastenersOK = true
            }
        }

    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        deckAreaTextfield.resignFirstResponder()
        deckWidthTextfield.resignFirstResponder()
        deckLengthTextfield.resignFirstResponder()
        boardLengthTextfield.resignFirstResponder()
        boardWidthTextfield.resignFirstResponder()
        pricePerBoardTextfield.resignFirstResponder()
        costOfFastenersTextfield.resignFirstResponder()
    }
    
    @IBAction func clearButtonPressed(_ sender: Any) {
        clearInputTab()
    }
    
    
    @IBAction func calculateButtonPressed(_ sender: UIButton) {
        self.view.endEditing(true)
        if defaults.integer(forKey: "type") == 0{
    
            if boardWidthTextfield.text == "" {
                boardWidthTextfield.text = "1"
                isWidthBoardOK = true
            }
            
            if boardLengthTextfield.text == "" {
                boardLengthTextfield.text = "1"
                isLengthBoardOK = true
            }
            
            if deckLengthTextfield.text == "" {
                deckLengthTextfield.text = "0"
                isDeckLengthOK = true
            }
            
            if deckWidthTextfield.text == "" {
                deckWidthTextfield.text = "0"
                isDeckWidthOK = true
            }
            
            if pricePerBoardTextfield.text == "" {
                pricePerBoardTextfield.text = "0"
                isPricePerBoardOK = true
            }
            
            if costOfFastenersTextfield.text == "" {
                costOfFastenersTextfield.text = "0"
                isCostOfFastenersOK = true
            }
            
            if isWidthBoardOK && isLengthBoardOK && isDeckWidthOK && isDeckLengthOK && isPricePerBoardOK && isCostOfFastenersOK {
                //Get textfield text without space
                let boardWidthText = boardWidthTextfield.text?.stringByRemovingWhitespaces
                let boardLengthText = boardLengthTextfield.text?.stringByRemovingWhitespaces
                let deckWidthText = deckWidthTextfield.text?.stringByRemovingWhitespaces
                let deckLengthText = deckLengthTextfield.text?.stringByRemovingWhitespaces
                let pricePerBoardText = pricePerBoardTextfield.text?.stringByRemovingWhitespaces
                let costOfFastenersText = costOfFastenersTextfield.text?.stringByRemovingWhitespaces
                
                //Change value to integer, decimal
                let boardWidthDouble = Double(boardWidthText!.replacingOccurrences(of: ",", with: ""))
                let boardLengthDouble = Double(boardLengthText!.replacingOccurrences(of: ",", with: ""))
                let deckWidthDouble = Double(deckWidthText!.replacingOccurrences(of: ",", with: ""))
                let deckLengthDouble = Double(deckLengthText!.replacingOccurrences(of: ",", with: ""))
                let pricePerBoardDouble = Double(pricePerBoardText!.replacingOccurrences(of: ",", with: ""))
                let costOfFastenersDouble = Double(costOfFastenersText!.replacingOccurrences(of: ",", with: ""))
                
                //Change sideLength to M
                let boardWidthToM = Tools.toM(value: boardWidthDouble!, defaultString: "boardWidth")
                let boardLengthToM = Tools.toM(value: boardLengthDouble!, defaultString: "boardLength")
                let deckWidthToM = Tools.toM(value: deckWidthDouble!, defaultString: "deckWidth")
                let deckLengthToM = Tools.toM(value: deckLengthDouble!, defaultString: "deckLength")
                
                let boardAreaByM = boardWidthToM * boardLengthToM
                let deckAreaByM = deckWidthToM * deckLengthToM
                
                boardNeeded = deckAreaByM / boardAreaByM
                boardNeededNotWaste = boardNeeded
                boardNeededNotWaste = boardNeededNotWaste.rounded(.awayFromZero)
                boardNeeded = boardNeeded + boardNeeded * 0.1
                boardNeeded = boardNeeded.rounded(.awayFromZero)
                
                screws = (deckAreaByM * 10.7639104) * 3.5
                screws = screws.rounded(.awayFromZero)
                
                hiddenClip = (deckAreaByM * 10.7639104) * (3.5/2)
                hiddenClip = hiddenClip.rounded(.awayFromZero)
                
                priceNeeded = boardNeeded * pricePerBoardDouble!
                priceNeeded = round(priceNeeded * 100) / 100
                
                totalCost = priceNeeded + costOfFastenersDouble!
                totalCost = round(totalCost * 100) / 100
                
                performSegue(withIdentifier: "result", sender: self)
            }
            
        }else {
            if boardWidthTextfield.text == "" {
                boardWidthTextfield.text = "1"
                isWidthBoardOK = true
            }
            
            if boardLengthTextfield.text == "" {
                boardLengthTextfield.text = "1"
                isLengthBoardOK = true
            }
            
            if deckAreaTextfield.text == "" {
                deckAreaTextfield.text = "0"
                isDeckAreaOK = true
            }
            
            
            if pricePerBoardTextfield.text == "" {
                pricePerBoardTextfield.text = "0"
                isPricePerBoardOK = true
            }
            
            if costOfFastenersTextfield.text == "" {
                costOfFastenersTextfield.text = "0"
                isCostOfFastenersOK = true
            }
            
            if isWidthBoardOK && isLengthBoardOK && isDeckWidthOK && isDeckLengthOK && isPricePerBoardOK && isCostOfFastenersOK {
                //Get textfield text without space
                let boardWidthText = boardWidthTextfield.text?.stringByRemovingWhitespaces
                let boardLengthText = boardLengthTextfield.text?.stringByRemovingWhitespaces
                let deckAreaText = deckAreaTextfield.text?.stringByRemovingWhitespaces
                let pricePerBoardText = pricePerBoardTextfield.text?.stringByRemovingWhitespaces
                let costOfFastenersText = costOfFastenersTextfield.text?.stringByRemovingWhitespaces
                
                //Change value to integer, decimal
                let boardWidthDouble = Double(boardWidthText!.replacingOccurrences(of: ",", with: ""))
                let boardLengthDouble = Double(boardLengthText!.replacingOccurrences(of: ",", with: ""))
                let deckAreaDouble = Double(deckAreaText!.replacingOccurrences(of: ",", with: ""))
                let pricePerBoardDouble = Double(pricePerBoardText!.replacingOccurrences(of: ",", with: ""))
                let costOfFastenersDouble = Double(costOfFastenersText!.replacingOccurrences(of: ",", with: ""))
                
                //Change sideLength to M
                let boardWidthToM = Tools.toM(value: boardWidthDouble!, defaultString: "boardWidth")
                let boardLengthToM = Tools.toM(value: boardLengthDouble!, defaultString: "boardLength")
                let deckAreaToM2 = Tools.toM2(value: deckAreaDouble!, defaultString: "deckArea")
                
                let boardAreaByM = boardWidthToM * boardLengthToM
                let deckAreaByM = deckAreaToM2
                
                boardNeeded = deckAreaByM / boardAreaByM
                boardNeededNotWaste = boardNeeded
                boardNeededNotWaste = boardNeededNotWaste.rounded(.awayFromZero)
                boardNeeded = boardNeeded + boardNeeded * 0.1
                boardNeeded = boardNeeded.rounded(.awayFromZero)
                
                screws = (deckAreaByM * 10.7639104) * 3.5
                screws = screws.rounded(.awayFromZero)
                
                hiddenClip = (deckAreaByM * 10.7639104) * (3.5/2)
                hiddenClip = hiddenClip.rounded(.awayFromZero)
                
                priceNeeded = boardNeeded * pricePerBoardDouble!
                priceNeeded = round(priceNeeded * 100) / 100
                
                totalCost = priceNeeded + costOfFastenersDouble!
                totalCost = round(totalCost * 100) / 100
                
                performSegue(withIdentifier: "result", sender: self)
            }
        }
        
    }
    
    func clearInputTab() {
        deckAreaTextfield.text = ""
        deckWidthTextfield.text = ""
        deckLengthTextfield.text = ""
        boardLengthTextfield.text = ""
        boardWidthTextfield.text = ""
        pricePerBoardTextfield.text = ""
        costOfFastenersTextfield.text = ""
        
        deckAreaTextfield.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        deckWidthTextfield.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        deckLengthTextfield.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        boardLengthTextfield.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        boardWidthTextfield.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        pricePerBoardTextfield.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        costOfFastenersTextfield.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        deckAreaErrorLabel.isHidden = true
        deckLengthErrorLabel.isHidden = true
        deckWidthErrorLabel.isHidden = true
        boardLengthErrorLabel.isHidden = true
        boardWidthErrorLabel.isHidden = true
        pricePerBoardErrorLabel.isHidden = true
        costOfFastenersErrorLabel.isHidden = true
        
        isDeckAreaOK = true
        isDeckLengthOK = true
        isDeckWidthOK = true
        isLengthBoardOK = true
        isWidthBoardOK = true
        isPricePerBoardOK = true
        isCostOfFastenersOK = true
        
    }
    
    @IBAction func shapeTypeButtonPressed(_ sender: UIButton) {
        AlertService.showShapeInTypeButton(in: self) { (index) in
            if index == 0 {
                if self.defaults.integer(forKey: "type") != 0 {
                    self.typeButton.setTitle("Rectangular", for: .normal)
                    self.defaults.set(0, forKey: "type")
                    self.inputConstructer(length: true, width: true, area: false)
                }
                
            }else if index == 1 {
                if self.defaults.integer(forKey: "type") != 1 {
                    self.typeButton.setTitle("Area", for: .normal)
                    self.defaults.set(1, forKey: "type")
                    self.inputConstructer(length: false, width: false, area: true)
                }
            }
        }
    }
    
    func inputConstructer(length: Bool, width: Bool, area: Bool) {
        DispatchQueue.main.async {
            self.deckLengthStackView.isHidden = !length
            self.deckWidthStackView.isHidden = !width
            self.deckAreaStackView.isHidden = !area
            
            if length {
                self.areaAreaConstraint.constant = 0
                self.lengthConstraint.constant = 20
                self.widthConstraint.constant = 74
                
            }else if area {
                self.areaAreaConstraint.constant = 20
                self.lengthConstraint.constant = 0
                self.widthConstraint.constant = 20
                
            }
            self.clearInputTab()
        }
        
    }
    
    
    @IBAction func deckLengthButtonPressed(_ sender: Any) {
        AlertService.showBasicUnitButton(in: self) { (index) in
            if index == 1 {
                self.deckLengthButton.setTitle("in", for: .normal)
                self.defaults.set(index, forKey: "deckLength")
            }else if index == 2 {
                self.deckLengthButton.setTitle("ft", for: .normal)
                self.defaults.set(index, forKey: "deckLength")
            }else if index == 3 {
                self.deckLengthButton.setTitle("yd", for: .normal)
                self.defaults.set(index, forKey: "deckLength")
            }else if index == 4 {
                self.deckLengthButton.setTitle("cm", for: .normal)
                self.defaults.set(index, forKey: "deckLength")
            }else if index == 5 {
                self.deckLengthButton.setTitle("m", for: .normal)
                self.defaults.set(index, forKey: "deckLength")
            }
        }
    }
    
    @IBAction func deckWidthButtonPressed(_ sender: Any) {
        AlertService.showBasicUnitButton(in: self) { (index) in
            if index == 1 {
                self.deckWidthButton.setTitle("in", for: .normal)
                self.defaults.set(index, forKey: "deckWidth")
            }else if index == 2 {
                self.deckWidthButton.setTitle("ft", for: .normal)
                self.defaults.set(index, forKey: "deckWidth")
            }else if index == 3 {
                self.deckWidthButton.setTitle("yd", for: .normal)
                self.defaults.set(index, forKey: "deckWidth")
            }else if index == 4 {
                self.deckWidthButton.setTitle("cm", for: .normal)
                self.defaults.set(index, forKey: "deckWidth")
            }else if index == 5 {
                self.deckWidthButton.setTitle("m", for: .normal)
                self.defaults.set(index, forKey: "deckWidth")
            }
        }
    }
    
    @IBAction func deckAreaButtonPressed(_ sender: Any) {
        AlertService.showAreaUnitButton(in: self) { (index) in
            if index == 1 {
                self.deckAreaButton.setTitle("in²", for: .normal)
                self.defaults.set(index, forKey: "deckArea")
            }else if index == 2 {
                self.deckAreaButton.setTitle("ft²", for: .normal)
                self.defaults.set(index, forKey: "deckArea")
            }else if index == 3 {
                self.deckAreaButton.setTitle("yd²", for: .normal)
                self.defaults.set(index, forKey: "deckArea")
            }else if index == 4 {
                self.deckAreaButton.setTitle("cm²", for: .normal)
                self.defaults.set(index, forKey: "deckArea")
            }else if index == 5 {
                self.deckAreaButton.setTitle("m²", for: .normal)
                self.defaults.set(index, forKey: "deckArea")
            }
        }
    }
    
    @IBAction func boardWidthButtonPressed(_ sender: Any) {
        AlertService.showBasicUnitButton(in: self) { (index) in
            if index == 1 {
                self.boardWidthButton.setTitle("in", for: .normal)
                self.defaults.set(index, forKey: "boardWidth")
            }else if index == 2 {
                self.boardWidthButton.setTitle("ft", for: .normal)
                self.defaults.set(index, forKey: "boardWidth")
            }else if index == 3 {
                self.boardWidthButton.setTitle("yd", for: .normal)
                self.defaults.set(index, forKey: "boardWidth")
            }else if index == 4 {
                self.boardWidthButton.setTitle("cm", for: .normal)
                self.defaults.set(index, forKey: "boardWidth")
            }else if index == 5 {
                self.boardWidthButton.setTitle("m", for: .normal)
                self.defaults.set(index, forKey: "boardWidth")
            }
        }
    }
    
    @IBAction func boardLengthButtonPressed(_ sender: Any) {
        AlertService.showBasicUnitButton(in: self) { (index) in
            if index == 1 {
                self.boardLengthButton.setTitle("in", for: .normal)
                self.defaults.set(index, forKey: "boardLength")
            }else if index == 2 {
                self.boardLengthButton.setTitle("ft", for: .normal)
                self.defaults.set(index, forKey: "boardLength")
            }else if index == 3 {
                self.boardLengthButton.setTitle("yd", for: .normal)
                self.defaults.set(index, forKey: "boardLength")
            }else if index == 4 {
                self.boardLengthButton.setTitle("cm", for: .normal)
                self.defaults.set(index, forKey: "boardLength")
            }else if index == 5 {
                self.boardLengthButton.setTitle("m", for: .normal)
                self.defaults.set(index, forKey: "boardLength")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "result" {
            if let resultController = segue.destination as? ResultController {
                resultController.boardNeeded = boardNeeded
                resultController.screws = screws
                resultController.hiddenClip = hiddenClip
                resultController.priceNeeded = priceNeeded
                resultController.totalCost = totalCost
                resultController.boardNeededNotWaste = boardNeededNotWaste
                
            }
        }
    }
    
}

