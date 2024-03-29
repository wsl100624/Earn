//
//  ResultViewController.swift
//  Earn
//
//  Created by Will Wang on 10/16/18.
//  Copyright © 2018 Will Wang. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var earnLabel: UILabel!
    
    @IBAction func saveBtnPressed(_ sender: UIButton) {
        //showNamingWindow()
    }
    
    var passedValue: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addAttributedResultText()
        
    }
    
    func addAttributedResultText() {
        let positiveAttributedText = NSMutableAttributedString(string: "$",
                                                               attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 40, weight: .thin)])
        let negativeAttributedText = NSMutableAttributedString(string: "-$",
                                                               attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 40, weight: .thin),
                                                                            NSAttributedString.Key.foregroundColor: UIColor.red])
        if passedValue >= 0 {
            positiveAttributedText.append(NSAttributedString(string: String(format: "%.2f", passedValue),
                                                             attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 75, weight: .thin)]))
            
            earnLabel.attributedText = positiveAttributedText
            
        } else {
            let negativeValue = -passedValue
            negativeAttributedText.append(NSAttributedString(string: String(format: "%.2f", negativeValue),
                                                             attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 75, weight: .thin),
                                                                          NSAttributedString.Key.foregroundColor: UIColor.red]))
            
            earnLabel.attributedText = negativeAttributedText
        }
    }

//    func showNamingWindow() {
//
//        let alert = UIAlertController(title: "Save", message: "你个锤子，输个名字才能保存", preferredStyle: .alert)
//
//        alert.addTextField { (textField) in
//            textField.placeholder = "Name"
//        }
//
//        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
//            let textField = alert.textFields![0] as UITextField
//            if let newName = textField.text {
//                finalEarnData.append(Earn(name: newName, earn: self.passedValue))
//                self.dismiss(animated: true, completion: nil)
//            }
//        }))
//
//        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: "Default action"), style: .cancel, handler: { _ in
//            NSLog("Cancel Pressed")
//        }))
//
//        self.present(alert, animated: true, completion: nil)
//
//    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSavingVC" {
            guard let view = segue.destination as? SavingViewController else { return }
            view.passedValue = passedValue
        } else {
            print("not showResultVC")
        }
    }
    

}
