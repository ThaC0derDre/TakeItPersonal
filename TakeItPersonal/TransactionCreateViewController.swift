//
//  TransactionCreateViewController.swift
//  TakeItPersonal
//
//  Created by Andres Gutierrez on 12/10/21.
//

import UIKit
import RealmSwift

class TransactionCreateViewController: UITableView {

    let realm = try! Realm()
    
   
    
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var noteTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    
    
    
    
   
    
    
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        
        let transactionsArray = TransactionViewController()
        
        let amount = amountTextField.text
        let amountDouble = Double(amount!)!
        let note = noteTextField.text!
        let date = dateTextField.text!
        
        if let currentCategory = transactionsArray.selectedMonth {
            do{
                try self.realm.write{
              let newTransaction = Ledgers()
                newTransaction.amount = amountDouble
                newTransaction.date = date
                newTransaction.notes = note
                    currentCategory.ledger.append(newTransaction)
                }
            }catch{
                print("Error creating new Item \(error)")
                
            }
           
        }
        
        self.inputViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        
        
    }
}
