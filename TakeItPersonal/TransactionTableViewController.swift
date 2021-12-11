//
//  TransactionTableViewController.swift
//  TakeItPersonal
//
//  Created by Andres Gutierrez on 12/11/21.
//

import UIKit
import RealmSwift

class TransactionTableViewController: UITableViewController {
    let realm = try! Realm()

    var transactionsArray: Results<Ledgers>?

    
    var selectedMonth: Months? {
        didSet{
          //  loadItems()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LedgerCell")  as! TransactionsTableViewCell
        if let label = transactionsArray?[indexPath.row]{
        cell.amountLabel?.text = ("$\(label)")
        cell.notesLabel?.text = label.notes
        cell.dateLabel?.text = label.date.description
        }
        return cell
            
    }
    
     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return transactionsArray?.count ?? 1
     }
     
    
    
    
//    func loadItems(){
//        transactionsArray = self.selectedMonth
//
//        tableView.reloadData()
//    }

    
    
}
