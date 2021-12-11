//
//  TransactionCreateViewController.swift
//  TakeItPersonal
//
//  Created by Andres Gutierrez on 12/10/21.
//

import UIKit
import RealmSwift

class TransactionCreateViewController: UITableViewController {

    
    
    @IBOutlet weak var noteTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
   
    
    
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        let amount = amountTextField.text
        let note = noteTextField.text
        let date = Date()
        
        let formatter = DateFormatter()
        formatter.timeZone = .current
        formatter.locale = .current
        formatter.dateFormat = "MM/dd/yyyy"
        
        let theDate = formatter.string(from: date)
    }
}
