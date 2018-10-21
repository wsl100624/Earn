//
//  ViewController.swift
//  Earn
//
//  Created by Will Wang on 10/15/18.
//  Copyright © 2018 Will Wang. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireSwiftyJSON
import SwiftyJSON

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var originalPriceTextField: UITextField!
    @IBOutlet weak var sellPriceTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    
    @IBOutlet weak var calculatBtn: UIButton!
    @IBOutlet weak var makeUpBtn: UIButton!

    
    @IBAction func calculatePressed(_ sender: UIButton) {
        showFinalResult()
    }
    
    var currentUSDRate : Double = 0.0
    var finalResult : Double = 0.0
    var pricePerPound : Double {
        var price = 0.0
        if makeUpBtn.isSelected {
            price = 5.5
        } else {
            price = 4.5
        }
        return price
    }
 
    let url_USD = "https://enscurrency.com/api/convert?api_key=7a137b95b1694c3289de5d5eea4fbed9&source=CNY&target=USD"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCurrentUSDRate()
        addTapGestureOnView()
        addNotifierForKeyboard()
        addMakeUpBtn()
        
        scrollView.keyboardDismissMode = .interactive
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        originalPriceTextField.text = ""
        sellPriceTextField.text = ""
        weightTextField.text = ""
        
        finalResult = 0.0
        
        calculatBtn.isEnabled = true
        makeUpBtn.isSelected = false
    }
    
    func addMakeUpBtn() {
        makeUpBtn.setImage(UIImage(named: "btn_makeup_selected"), for: UIControl.State.selected)
        makeUpBtn.setImage(UIImage(named: "btn_makeup"), for: UIControl.State.normal)
        makeUpBtn.addTarget(self, action: #selector(makeUpBtnStateSwitch), for: UIControl.Event.touchUpInside)
        makeUpBtn.addTarget(self, action: #selector(dismissKeyboard(gesture:)), for: UIControl.Event.touchUpInside)
    
    }

    
    @objc func makeUpBtnStateSwitch() {
        makeUpBtn.isSelected = !makeUpBtn.isSelected
    }
    
    func addNotifierForKeyboard() {
        let notifier = NotificationCenter.default
        notifier.addObserver(self, selector: #selector(showKeyboardInScrollView), name: UIResponder.keyboardWillShowNotification , object: nil)
        notifier.addObserver(self, selector: #selector(hideKeyboardInScrollView), name: UIResponder.keyboardWillHideNotification , object: nil)
    }
    
    @objc func showKeyboardInScrollView(notification: Notification) {
        //Actions when notification is received
        let userInfo = notification.userInfo!
        
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        scrollView.contentInset = contentInset
        
    }
    
    @objc func hideKeyboardInScrollView(notification: Notification) {
        //Actions when notification is received
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
        
    }

    
    func addTapGestureOnView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(gesture:)))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(gesture: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    
    @IBAction func didUnwindFromResultViewController(_ sender: UIStoryboardSegue) {}
    
    
    func getCurrentUSDRate() {
        
        Alamofire.request(url_USD).responseJSON {
            response in
            
            switch response.result {
                
            case .success:
                let priceData : JSON = JSON(response.result.value!)
                
                guard let rate = priceData["target"]["USD"].double else { return }
                
                self.currentUSDRate = rate
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func showFinalResult() {
        
        let sellPriceInCNY = sellPriceTextField.text!
        let originalPriceInUSD = originalPriceTextField.text!
        let weight = weightTextField.text!
        
        if sellPriceInCNY.isEmpty || originalPriceInUSD.isEmpty || weight.isEmpty {
            return
        } else {
            
            finalResult = Double(sellPriceInCNY)!*currentUSDRate - Double(originalPriceInUSD)! - Double(weight)!*self.pricePerPound
            calculatBtn.isEnabled = false
            self.performSegue(withIdentifier: "showResultVC", sender: self)
        }
        
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showResultVC" {
            guard let view = segue.destination as? ResultViewController else { return }
            view.passedValue = finalResult
            loadingIndicator.stopAnimating()
        } else {
            print("not showResultVC")
        }
    }
}

