//
//  TransactionViewController.swift
//  TakeItPersonal
//
//  Created by Andres Gutierrez on 12/12/21.
//

import Foundation
import RealmSwift

class TransactionViewController: UITableViewController {
    
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

    
    func loadItems(){
        transactionsArray = selectedMonth?.ledger.sorted(byKeyPath: "date", ascending: true)

        tableView.reloadData()
    }

    
    
}
