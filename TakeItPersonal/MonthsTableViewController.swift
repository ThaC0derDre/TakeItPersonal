//
//  MonthsTableViewController.swift
//  TakeItPersonal
//
//  Created by Andres Gutierrez on 12/10/21.
//

import UIKit
import RealmSwift
class MonthsTableViewController: UITableViewController, UIGestureRecognizerDelegate {
    
    let realm = try! Realm()
    
    var datesArray: Results<Months>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        load()
        
        self.hideKeyboardWhenTappedAround()
        
    }
    
    //MARK: - TableView DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datesArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let label = datesArray?[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: "MonthsCell", for: indexPath)
        cell.textLabel?.text = label?.dates ?? "No Months Added yet"
        
        return cell
        
    }
    
    
    //MARK: - Add New Dates
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToLedger", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TransactionViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedMonth = datesArray?[indexPath.row]
        }
    }
    

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add Month", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { action in
            let newDate = Months()
            newDate.dates = textField.text!
            self.save(date: newDate)
          // print("THISSSSS is the output : \(self.textField.text)")
            //self.load()
        }
        
        alert.addAction(action)
        alert.addTextField { alertTextField in
            
            alertTextField.placeholder = "Add New Month"
            textField = alertTextField
            
        }
        present(alert, animated: true, completion: nil)
        
        
        
    }

    //MARK: - Functions
    func save(date: Months){
    do{
        try realm.write(){
        realm.add(date)
        }
    }catch{
        print("Error saving Category: \(error)")
    }
        tableView.reloadData()
    }
    
    func load(){
        
        datesArray = realm.objects(Months.self)
        
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
        guard let categories = datesArray?[indexPath.row] else {
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
        load()
           return true
}
    
  
    
}


extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
