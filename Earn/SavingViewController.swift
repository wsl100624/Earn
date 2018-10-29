//
//  SavingViewController.swift
//  Earn
//
//  Created by Will Wang on 10/25/18.
//  Copyright © 2018 Will Wang. All rights reserved.
//

import UIKit

class SavingViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var itemsTextView: UITextView!
    
    var recordVC = RecordViewController()
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        
        if let newName = nameTextField.text{
            if let newItems = itemsTextView.text {
                finalEarnData.append(Earn(name: newName, earn: self.passedValue, items: newItems))
            }
        }
    }
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    let placeholder = "item1\nitem2\nitem3\n..."
    var passedValue: Double = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        itemsTextView.text = placeholder
        itemsTextView.textColor = UIColor.officialApplePlaceholderGray
        
        nameTextField.becomeFirstResponder()
        addTapGestureOnView()
        addNotifierForKeyboard()
        scrollView.keyboardDismissMode = .interactive
        
    }
    
    func addTapGestureOnView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(gesture:)))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(gesture: UITapGestureRecognizer) {
        view.endEditing(true)
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
   

}

extension SavingViewController: UITextViewDelegate, UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        itemsTextView.becomeFirstResponder()
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if itemsTextView.textColor == UIColor.officialApplePlaceholderGray {
            itemsTextView.text = nil
            itemsTextView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if itemsTextView.text.isEmpty {
            itemsTextView.text = placeholder
            itemsTextView.textColor = UIColor.officialApplePlaceholderGray
        }
        
    }
    
}

extension UIColor {
    static var officialApplePlaceholderGray: UIColor {
        return UIColor(red: 0, green: 0, blue: 0.0980392, alpha: 0.22)
    }
}
