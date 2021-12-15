//
//  TransactionViewController.swift
//  TakeItPersonal
//
//  Created by Andres Gutierrez on 12/12/21.
//

import Foundation
import RealmSwift

class TransactionViewController: UITableViewController {
    
    var totalSumofTransactionsThisMonth = 0.0
    
    let realm = try! Realm()

    var transactionsArray: Results<Ledgers>?

    
    var selectedMonth: Months? {
        didSet{
         loadItems()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LedgerCell", for: indexPath) as! TransactionCell
        if let label = transactionsArray?[indexPath.row]{
            cell.amountLabel?.text =  ("$\(label.amount)")
        cell.notesLabel?.text = label.notes
        cell.dateLabel?.text = label.date.description
        } else{
            cell.textLabel?.text = "No Transactions Recorded Yet."
        }
        return cell
            
    }
    
    
    
     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return transactionsArray?.count ?? 1
     }
     
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    @IBAction func newLedgerPressed(_ sender: UIBarButtonItem) {
//        if let testerTimmy = selectedMonth{
//
//            print("OHHHHHHHHHHHHHHHHHHHHHH K, Here Is That: \(testerTimmy.ledger.value(forKey: "amount"))")
//        }
        let alert = UIAlertController(title: "Add Transactions", message: "", preferredStyle: .alert)
        var amountTextField = UITextField()
        var dateTextField = UITextField()
        var notesTextField = UITextField()
        
        
        let action = UIAlertAction(title: "Add Item", style: .default) { action in
            
            let amountString = amountTextField.text
            
            if let currentMonth = self.selectedMonth {
                do{
                    try self.realm.write{
                  let newItem = Ledgers()
                        if let amountDouble = Double(amountString!){
                            newItem.amount = amountDouble
                        }else{
                            newItem.amount = 0.0
                        }
                        newItem.notes = notesTextField.text!
                        newItem.date = dateTextField.text!
//                        newItem.sumTotal += newItem.amount
                        currentMonth.ledger.append(newItem)
                    }
                }catch{
                    print("Error creating new Item \(error)")
                    
                }
                self.tableView.reloadData()
                self.getSum()
            }
            
        }
        alert.addTextField { (date) in
            date.placeholder = "12/01"
            dateTextField = date
        }
        alert.addTextField { (amount) in
            amount.placeholder = "$9.99"
            amountTextField = amount
            amount.keyboardType = .decimalPad
        }
        
        alert.addTextField { (notes) in
            notes.placeholder = "What'd you purchase?"
            notesTextField = notes
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    func loadItems(){
        transactionsArray = selectedMonth?.ledger.sorted(byKeyPath: "date", ascending: true)

        tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let trash = UIContextualAction(style: .destructive,
                                       title: "Trash") { [weak self] (action, view, completionHandler) in
            
            completionHandler(true)
            let result = self?.delete(at: indexPath) ?? false
            completionHandler(result)
        }
        trash.backgroundColor = .systemRed
        let configuration = UISwipeActionsConfiguration(actions: [trash])

        return configuration
    }
    
    func delete(at indexPath: IndexPath) -> Bool {
        // Check if there is a category at provided row
        guard let categories = transactionsArray?[indexPath.row] else {
            return false
        }
        // Delete data from persistent storage
        do {
            // Open transaction
        try realm.write {
                // Insert category
            realm.delete(categories)
        }
        } catch {
            fatalError("Error deleting Category: \(error)")
        }
        loadItems()
        getSum()
           return true
}
    func getSum(){
        var falsey = 0.0
        if let testerTimmy = selectedMonth{
            let sumArray:Array = testerTimmy.ledger.value(forKey: "amount")
            var theRealArray:Array<String> = []
            for i in sumArray {
                let changerToString = String(describing: i)
                theRealArray.append(changerToString)
            }
            
            var theFinalArray:Array<Double> = []
            
            for i in theRealArray{

                if let gotEm = Double(i){
                    theFinalArray.append(gotEm)
                }
            }
            for l in theFinalArray{
                falsey += l
                
            }
            totalSumofTransactionsThisMonth = round(1000.0 * falsey) / 1000.0
            print(totalSumofTransactionsThisMonth)
            print("OHHHHHHHHHHHHHHHHHHHHHH K, Here Is That: \(testerTimmy.ledger.value(forKey: "amount"))")
        }
    }
    
}
