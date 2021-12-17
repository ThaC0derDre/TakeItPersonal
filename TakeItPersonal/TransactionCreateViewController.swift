//
//  TransactionCreateViewController.swift
//  TakeItPersonal
//
//  Created by Andres Gutierrez on 12/10/21.
//

import UIKit
import RealmSwift

protocol AddLedgerDelegate {
    func addTransaction(ledger: Ledgers)
}

class TransactionCreateViewController: UITableView {
let ledgers = Ledgers()
    let realm = try! Realm()
    
   
    
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var noteTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    
    
    
    
   
    
    
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        
//        let transactionsArray = TransactionViewController()
        
        let amount = amountTextField.text
        let amountDouble = Double(amount!)!
        let note = noteTextField.text ?? ""
        let date = dateTextField.text ?? ""
            submitTransaction(amount: amountDouble, note: note, date: date)
//        if let currentCategory = transactionsArray.selectedMonth {
//            do{
//                try self.realm.write{
//              let newTransaction = Ledgers()
//                newTransaction.amount = amountDouble
//                newTransaction.date = date
//                newTransaction.notes = note
//                    currentCategory.ledger.append(newTransaction)
//                }
//            }catch{
//                print("Error creating new Item \(error)")
//
//            }
           
        }
        
//        self.inputViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        
        
    
func submitTransaction(amount: Double, note: String, date: String ){
        
    let newTransaction = Ledgers()
      newTransaction.amount = amount
      newTransaction.date = date
      newTransaction.notes = note
    
//        let theAmount = Ledgers(value: amount)
//        let theNotes = Ledgers(value: note)
//        let theDate = Ledgers(value: date)
    print(newTransaction)
    
}
}
