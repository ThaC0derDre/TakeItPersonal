//
//  MonthsTableViewController.swift
//  TakeItPersonal
//
//  Created by Andres Gutierrez on 12/10/21.
//

import UIKit
import RealmSwift
class MonthsTableViewController: UITableViewController {
    
    var textField = UITextField()
    let datePicker = UIDatePicker()
    
    var months = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    //MARK: - TableView DataSource Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MonthsCell", for: indexPath)
        cell.textLabel?.text = months[indexPath.row]
        
        return cell
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return months.count
    }
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        
        let alert = UIAlertController(title: "Add Month", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { action in
            
        }
        
        alert.addAction(action)
        alert.addTextField { alertTextField in
            
            alertTextField.placeholder = "Add New Month"
            
            
            
            let toolBar = UIToolbar()
            toolBar.sizeToFit()
            
            let barButton = UIBarButtonItem(barButtonSystemItem: .done, target: self,
                                            action: #selector (self.doneSelectingDate))
            toolBar.setItems([barButton], animated: true)
            
            alertTextField.inputAccessoryView = toolBar
           alertTextField.inputView = self.datePicker
            self.datePicker.preferredDatePickerStyle = .wheels
            self.datePicker.datePickerMode = .date
            self.textField = alertTextField
        }
        present(alert, animated: true, completion: nil)
        
        
        
    }
    @objc func doneSelectingDate(){
       textField.text = "\(datePicker.date)"
       self.view.endEditing(true)
   }
    
    //MARK: - Funtions
//    func showDatePicker(){
//        let textField = UITextField()
//        let toolBar = UIToolbar()
//        toolBar.sizeToFit()
//
//        let barButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil,
//                                        action: #selector (doneSelectingDate))
//        toolBar.setItems([barButton], animated: true)
//
//        textField.inputAccessoryView = toolBar
//        textField.inputView = datePicker
//        datePicker.preferredDatePickerStyle = .wheels
//        datePicker.datePickerMode = .date
//
//
//    }
    
   

}
